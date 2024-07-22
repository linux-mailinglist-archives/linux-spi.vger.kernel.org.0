Return-Path: <linux-spi+bounces-3919-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D31D79392F7
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jul 2024 19:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A606B217E7
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jul 2024 17:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4706D16EB41;
	Mon, 22 Jul 2024 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apCNvN3b"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE5CC2FD;
	Mon, 22 Jul 2024 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668248; cv=none; b=GPUVSDL9mJWr163EHxtvmRdPVh/ZsqoQBeCTXeiY5ZrI7T6ivTNvWZZP87lemI2OQxGxCucYluL0BbKQeZUozHkIpZoqY/vfzuanH7gPeL7lrPbHhLskKVDPTFxhyrdUXGuJl1CVQ+F+CKikQKc7V4UB1d1GPRuOw11Vuzsp8sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668248; c=relaxed/simple;
	bh=j/24hc90M2iaO98/dhzrJosZD8LY9r2SIoiMarEefWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaAOJtpaofG2S8nzMDMMSnwZddZ9qGjKJdOZb0T4Il7rDlKeEGoZh6FWLBhg+OjA4jb2Zi4zR2JewYD8ed1xfKhxJCOKP2cZ+sxrJNQQHiKC5ERs0cMo1ZorT25shYxmPxFIst5fhj9f1pLYikHOJEQg/thcY0dg/k3niZKtx10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apCNvN3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B673EC116B1;
	Mon, 22 Jul 2024 17:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721668247;
	bh=j/24hc90M2iaO98/dhzrJosZD8LY9r2SIoiMarEefWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=apCNvN3bJGd76wo4XSnWjUDJpPy/y5KAlcLEt5bxXyh/fuPAwe39fwabhiGzx4yH1
	 ImjV2LdQ7RgEcsjDoVmS+K6U74ODe7oTNnPGABVnIBFsIVefFUXsaPTYhcTTc0t5mf
	 IczkuI26Rpfmv9ulfXW83bA+tIsdjIYXQHIHOWea+n8N2rC0iuurbz/MEBf6s8zRq+
	 ADJdH9wQ7fRNc5nrnpicE2CDi2oP9NbusPlCGJmby5wasRSwumz6KP2DqO1aojhY8v
	 hm7Y/suGJCOMdMZCiPdgr5TPBp7bTYE38lyPMK+P1uj5wQfF0nLSdRfb/YMsgUrs5F
	 W036hCyqcNDCQ==
Date: Mon, 22 Jul 2024 18:10:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: make24@iscas.ac.cn, linux-spi@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>, Stefan Roese <sr@denx.de>,
	"Steven A. Falco" <sfalco@harris.com>
Subject: Re: [PATCH v3] spi: ppc4xx: handle irq_of_parse_and_map() errors
Message-ID: <2dbd470c-80aa-45af-9324-0e81e1d9196c@sirena.org.uk>
References: <20240722141822.1052370-1-make24@iscas.ac.cn>
 <bceb4055-e315-4c70-a682-228cb997f86c@web.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nGRrgRFczAjDJqWJ"
Content-Disposition: inline
In-Reply-To: <bceb4055-e315-4c70-a682-228cb997f86c@web.de>
X-Cookie: Everything you know is wrong!


--nGRrgRFczAjDJqWJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 05:42:23PM +0200, Markus Elfring wrote:
> =E2=80=A6
> > Signed-off-by: Ma Ke <make24@iscas.ac.cn>
>=20
> Will any contributors care more for rules also according to such informat=
ion?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.10#n398
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/researcher-guidelines.rst?h=3Dv6.10#n5

Feel free to ignore Markus, he has a long history of sending
unhelpful review comments and continues to ignore repeated requests
to stop.

--nGRrgRFczAjDJqWJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaekpIACgkQJNaLcl1U
h9Dfzgf9ETS3R9qrTmFHEJBj7vKJKStsraIfaakAVsynkjW2ES6IivvA71kkqcJp
uzZE7fa2I2nlu/xGfhBXQ/Bkhxl4nz9BpCufYnVnKPyi6I4JOuBTKTrf5CvyAEyX
+ziqdVUaqNu6ulIfLx7+Xh3UJ04QMb+8LlslefN5hpDzUNMYfAjf+rt9yJc+zKHK
HyJqawTORi+p3k66z+HhRKXBBlCaTMhChWfi56tgfg73+JjzgPO9VKUQNvcyxfYN
1omHnRCLZLKMBRQp3R3U1il5hxmKgqzdtDCiFRydpWLZjFfiG0ya98hu2fNqEMHZ
IEwfGk9RfYtzuAMiRp0SFjg0E1jppQ==
=xyVR
-----END PGP SIGNATURE-----

--nGRrgRFczAjDJqWJ--

