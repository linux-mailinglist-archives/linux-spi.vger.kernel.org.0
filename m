Return-Path: <linux-spi+bounces-6979-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62707A4B3EC
	for <lists+linux-spi@lfdr.de>; Sun,  2 Mar 2025 19:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739A718854CB
	for <lists+linux-spi@lfdr.de>; Sun,  2 Mar 2025 18:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BF81E5B69;
	Sun,  2 Mar 2025 18:03:39 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ECB1C5F39
	for <linux-spi@vger.kernel.org>; Sun,  2 Mar 2025 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740938619; cv=none; b=L4qV6Qqp2KVF5q6KIIT+YOjAqheHwQMOhXqLIyMz+PFrjBDXZPO4mr0a1rClk9U4StDkKZ3lboL70oCggWPl+RWKsfygh5K46ERFjtiR6ghYKd4O3kqMQ6OFGgWACM+iR7nt+2/LIQ29rm2O7DZvqePNpVuzo/MgYOad2YKQwm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740938619; c=relaxed/simple;
	bh=rGfKhL+MgrfeJ9Gj+uPV6Ero3IQVliaC6QfhlNguR5A=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=bBjvFpRXruOJw3PDhdZwudg6Q8akYfeG/p4u14Yx64q/7UjcyN6vUnp/iWwWSilzrXOQPU57MaBVKeLdhjq8EmwLh/7R1d96N4G+Db1Kc2Js4nS2/pHI8Yy64DGw3bDBWtF1FALI82OwI2jQ8DikOwt7g1SmKtpeqTlGlR6nG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1tonf8-007Sx4-0R;
	Sun, 02 Mar 2025 18:03:36 +0000
Received: from ben by deadeye with local (Exim 4.98)
	(envelope-from <ben@decadent.org.uk>)
	id 1tonf6-00000003rpJ-1KgY;
	Sun, 02 Mar 2025 19:03:36 +0100
Message-ID: <ee5f2de4a84c04df92644ea720b88497528004dc.camel@decadent.org.uk>
Subject: CVE-2021-47469: spi: Fix deadlock when adding SPI controllers on
 SPI buses
From: Ben Hutchings <ben@decadent.org.uk>
To: Mark Brown <broonie@kernel.org>, cve@kernel.org
Cc: linux-spi@vger.kernel.org
Date: Sun, 02 Mar 2025 19:03:30 +0100
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Cuw1ZW6bp4+1oxUCqfaQ"
User-Agent: Evolution 3.54.1-1 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-Cuw1ZW6bp4+1oxUCqfaQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

CVE-2021-47469 is supposed to be fixed by commit 6098475d4cb4 "spi: Fix
deadlock when adding SPI controllers on SPI buses"=C2=A0but I think this
assignment should be rejected.

The commit fixes a deadlock during addition of an SPI device.  Since SPI
does not support auto-discovery, I think that adding such a device
requires CAP_SYS_ADMIN privilege (but I'm not certain).

Since it is intended that a user with CAP_SYS_ADMIN can deny service
through the reboot system call, I don't think additional ways to do this
are security flaws.

Ben.

--=20
Ben Hutchings
Any smoothly functioning technology is indistinguishable
from a rigged demo.


--=-Cuw1ZW6bp4+1oxUCqfaQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmfEnXIACgkQ57/I7JWG
EQkeFg//RD7soBmMksTTmnHsH/O6Y4ByqaDRRrL1mr4sW9zK1SW+0e71KfvSZKrc
L9KexNe+wHfi+1lwf9S1H0zMPhRTgepyWysfmBO6rJWaxVSYlrvuO1BII7LRNf5y
o95KKtYzYxlaA7LOvW1s8XA5JnQ2OlyfSZn8FfPNlpX5TUm+eOXpGC/iTeF77Ee4
P9ewp1iSB7TLuFiAJpq3DKMM9cO47Ftl8DEIyV8NbMA18MirotHXKxc6YSyLWxD/
rCZ7CGKzaUeA+KvlzWx5GWscOgfsEpdduyg8DXSYRaSi1OWBUA4nuRLfjqI8qP81
LeltuBocxUJwQ7eBSgeI4wMi88hX96WpsBcp0v9ly7qr1Y01RmN8npgoANZ+2MRN
xHeKyaMT7xMpDgXLF6KGPba2XXooWuvqbbbbLl2iQyNtxeG2l+Xku5XWi7WLXgFt
9ff0qRPBsstEiWOgIHzIQN+pxf9KFPRXRap/4oRLqoerKZHRVxry/zJvJDEXsp8G
WORkItDSuwG17bSjamDbD+b65mAsLdGvdIqc0fVOBT31zrTF37jkOsNBvAWILzxR
ACeQw1vpK6cxP6mhe2dgIPgRND7kh4OgeafhPxVX0rtQon/0jhlIEBfXMN+PpZCz
3+n/7ENHBfOo0TWgJcT3Emry9LnD7Wsd7v7H8nYRdY7Lpl3owfU=
=AjgQ
-----END PGP SIGNATURE-----

--=-Cuw1ZW6bp4+1oxUCqfaQ--

