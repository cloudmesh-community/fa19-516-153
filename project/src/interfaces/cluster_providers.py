


class ClusterProvider:
    
    class AbstractClusterProvider:
        def __init__(self):
            raise NotImplementedError

    def nomad_manager(self):
        class NomadProvider:
            name="nomad"

    