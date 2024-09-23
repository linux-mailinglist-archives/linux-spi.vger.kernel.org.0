Return-Path: <linux-spi+bounces-4935-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F70B97EBC5
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 14:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C0B1F20EE3
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 12:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E487D197A83;
	Mon, 23 Sep 2024 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVAEqR+T"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C062380C0C
	for <linux-spi@vger.kernel.org>; Mon, 23 Sep 2024 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727096227; cv=none; b=QvKjJ7rkabeXsp39ob1DMDd0TVjFqthHI/KtMJHas+5/s4PXKyvczx9W/ArL6dQSeFeIf3AI5U0wvJr7qlnxHyAim0ffVtTijA5CK+VdnH6chHKNLIqXVjtVXmtrjyYeHUdJZIzxkJ8oQiAFbh2WWBKvWIgYrmkxR53z4d90K78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727096227; c=relaxed/simple;
	bh=94dO0fvKSD0KFYOpKw7sQcoqnjZf0/+quwFbdSK1QTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1EeZXbtGRbJcSaJ/qy8W2AR4Z4iaaORABorGznSq4Ih/d8w0Q7q5YPVtUW3rPE7OL/8LIJ77TgWT+i59+HlpD6fkLSnqfjVyydZWA06zkZ5SzP7oQDQwVW0/tnc6mbTMzs86DN+fo2FIkkbyRLawszZoraj0SQY/TAKFcKEf+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVAEqR+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E02C4CEC4;
	Mon, 23 Sep 2024 12:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727096227;
	bh=94dO0fvKSD0KFYOpKw7sQcoqnjZf0/+quwFbdSK1QTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rVAEqR+T5BNUQot+kOV6SYKze5+eZv4wvJe1LkUYV1fpc0NlOqLyYyVWxTHxJ1uGf
	 XDR9OcBibaoPGynNdGmxyRUs/IsZ0wAS6gWkjULwSOoB1IYjDaOQnfpd6BRzO9MUQq
	 /llpsk0xYNQicyVL46L+ldcIUIt2lKFQySN0pN1fG8seX8ynSPucEi68zgAmvP4w+h
	 hEVv4LF2iMj1sYHH8naVR7WKvFz0IEtcnc64LbRW4Ma7HHsIU4vryndBRVMUham9CP
	 WwJxdBoOVc4eXhTMvB5CGacOZrbO7kCAtVxka0zA0lzjfRZYG1HRMhIU86snWmiRHw
	 1rvouFIgY6MmQ==
Date: Mon, 23 Sep 2024 14:57:03 +0200
From: Mark Brown <broonie@kernel.org>
To: Ralf Glaser <glaser@iotmaxx.de>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: AW: migration from kernel 5.18.8 to kernel 6.10.3 spidev driver
 not loaded when device definition in DTS overlay
Message-ID: <ZvFlnzbkM5vI2ClJ@finisterre.sirena.org.uk>
References: <7bbd3bc198a84e25ba25e28a6989ba3cBEZP281MB3361E029FEE3756F30ACBA99A56C2@BEZP281MB3361.DEUP281.PROD.OUTLOOK.COM>
 <Zu2RVC1vGUh_-KYb@finisterre.sirena.org.uk>
 <BEZP281MB336107A0693341C9BB88B88DA56F2@BEZP281MB3361.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/Zl1zsKO2+qeAHx2"
Content-Disposition: inline
In-Reply-To: <BEZP281MB336107A0693341C9BB88B88DA56F2@BEZP281MB3361.DEUP281.PROD.OUTLOOK.COM>
X-Cookie: Editing is a rewording activity.


--/Zl1zsKO2+qeAHx2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 23, 2024 at 07:48:30AM +0000, Ralf Glaser wrote:

> should /sys/bus/spi/drivers/spidev exist when the spidev driver is available or is it created only if there is a suitable SPI device?

> Besides this i will ask the DT people if they have any ideas.

Yes, spidev should be there if the driver has been registered with the
core - my first guess would be that you're building spidev as a module
and something got confused with module autoloading.  Those drivers
directories enumerate all the drivers registered with the driver core
for each bus.

--/Zl1zsKO2+qeAHx2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbxZZ4ACgkQJNaLcl1U
h9AwNAf/cDKNPuVr/OuIVW5icte3jTiB8XgBMRdaZxOWgYlgB0JcLg3MGuQ87Y+R
HWnzf70/qa2/l+cYFIGp+7Ktz49jUccPC47JKBgR8JUzmr+8cpaoVAZAh9JJ0kJK
u36qWZFjkKQ929YyoAWxKKLZR5Lu4KhL1GbXgD4aGPrcUdD754e7CfacKkAx+p5O
JZc30MVD6LFwPX2RbnW94RqkM3jqPv2JICZjPCiUbtjHN3El3ouIyca/OsvMS+bN
FxDlrXAj/nEE+a+/mg7Mss+vsZHaMTg+Pp6oSi/P6ST5/MBQQa9flB19M+04AM3w
W/ILZvI8iQaSEMoOJvNNDkq17QIS6Q==
=b2Ab
-----END PGP SIGNATURE-----

--/Zl1zsKO2+qeAHx2--

