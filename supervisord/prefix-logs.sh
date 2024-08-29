#!/bin/bash

# Prefix stdout and stderr
exec 1> >( perl -ne '$| = 1; print "program='"${SUPERVISOR_GROUP_NAME}"' $_"' >&1)
exec 2> >( perl -ne '$| = 1; print "program='"${SUPERVISOR_GROUP_NAME}"' $_"' >&2)

exec "$@"
