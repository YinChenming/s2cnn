if [ ! -d ".venv" ]; then
  uv python install 3.9
  uv venv
fi
source .venv/bin/activate
uv pip install -r requirements.txt
python setup.py install --force
if [ ! -d "packages" ]; then
  mkdir -p "packages"
fi
cd packages || exit
if [ ! -d "lie_learn" ]; then
  git clone git@github.com:AMLab-Amsterdam/lie_learn.git --depth 1
fi
cd lie_learn || exit
python setup.py install
cd ..
if [ ! -d "vae_architecture" ]; then
  git clone git@github.com:NicolasLegendre1/vae_architecture.git --depth 1
fi
cd ..
cp packages/vae_architecture/J_dense_0-150.npy .venv/lib/python3.9/site-packages/lie_learn/representations/SO3/pinchon_hoggan/J_dense_0-150.npy
echo "all finished"
