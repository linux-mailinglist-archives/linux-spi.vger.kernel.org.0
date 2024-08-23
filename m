Return-Path: <linux-spi+bounces-4273-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8472A95CC35
	for <lists+linux-spi@lfdr.de>; Fri, 23 Aug 2024 14:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74AB1C218D0
	for <lists+linux-spi@lfdr.de>; Fri, 23 Aug 2024 12:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFF5358A7;
	Fri, 23 Aug 2024 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="UyR6++HB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EACF3A28D;
	Fri, 23 Aug 2024 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724415334; cv=none; b=PkWnAlsJXw1UiEq6hbHvR2B/Sw+lD3K0+mA8vYEyNxb4Uh2w5hDjGluwAbwKaN7SPjaEICaJzge2s7jD+lMWmMp+mRt/nRrzmNeyrxGCL8yqcRblbcZEZdbISkk/m6DutBcb5FKwo9rgcQ++mw+mlXxf3L48bHXP2h6sTq+C8sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724415334; c=relaxed/simple;
	bh=1v/8KbfeGCwfvhavOFD9X3prZgd/g3pYHdW7NHM/4h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ah/m+y8ZgN6QEx1bY/Xd06yxjbxjeRMwSQJ7KT8lYu7hlgYsboDDeq53NAJ+8IFDfowD3csfBvqPuNJWR715MPfHU2ZD9a/+l7lcon5hb2har23JhsDxxh5cjG1pAtFqM1oMwEbGjF1GB8s3y2KdUaoxaJU1lZrVI/qD4ercOmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=UyR6++HB; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724415316; x=1725020116; i=j.neuschaefer@gmx.net;
	bh=h0BQB0MX4qUA3/Dn+xSqWXZtaezatHOedl+Kg5HoD1c=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UyR6++HBhq6qq43EyD0NdghBR9fobTpWMSvyT34NWlTQBtODLblFUm9CuMFKv3JS
	 XvygoTUbydjTgTX4t98hXwetY/rtkQzfKswfbUQWG4XUKbc6nhaiJytqrUicOsZHl
	 5eJLJ+wrcaWSRvnd3aK9BPKuSLciQOjCmK6jPSSMcCHya9RxFbTJm2gq1D640334d
	 CDeEiq8GjM5EcJ2+Z3odyvYndGFwLPopKXN8RRoj7aNZo7t4B4sKhiceWb4MvezDn
	 T6DO6S9WN4G48lB1Fv8SM830sk/8XYpadz5rS7RrZ929n1rOIsOg6jfnZLe7EH7ac
	 zl6b5YqoX1MSxlpU4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([84.44.134.213]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5QF5-1siq6j37zx-008Cax; Fri, 23
 Aug 2024 14:15:16 +0200
Date: Fri, 23 Aug 2024 14:15:12 +0200
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: j.neuschaefer@gmx.net, broonie@kernel.org, openbmc@lists.ozlabs.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] spi: wpcm-fiu: Use
 devm_platform_ioremap_resource_byname()
Message-ID: <Zsh9UA4iXvMzm2HW@probook>
References: <20240820123518.1788294-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240820123518.1788294-1-ruanjinjie@huawei.com>
X-Provags-ID: V03:K1:K7cBbWoIShlD66049cmP2FqksWnx3SN+H5lXc21nFVbBvdqE/B9
 U2bnn5C7QchLuXPugvq4JJViBCFCyxJVwHaoue/jLmBmuHzBDQbssFZnv4pHZM8RoBmDBH7
 zYba+W1Q8G4bz9sj80cnVv94dxzFMArr6ng489n+Yf4GvsaFn7tehUrcGCpgtbCGe3bbFnS
 SSHutCmO/PK8eo7gE2wmA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Lh+VwlgWObU=;GJNmrYaMKTYmGGyPde2c8PtyC89
 d0XquKzpM3w9sQ3Ttun4EdmGS+2Yxr5xXHDiANRgVImt4CbvTqGf3qQsZIX7mJXXg5IOifawD
 4OasJRwKY7Qn1t01Lb5/BFZT4ZO21IKpCgwVMAXll7DMMn7njL41+g7ZkBnF7gDZjJ4z9emsn
 QLWXhoY4nh1hoBrdejLylxJptP6U1SekHXLHeFOSHt00rxWdq2fBgqhPAkXKdV2yax1U3l273
 YUSRzIfpK4mcuRjIBDLKPgaLirpchLDi35azvucT2uG85qO1ukyTLwU3oNwTH2jMT9mryxfsC
 /tm4VR0xaQ9PUDttUlqpzGHZotLvYvcF8z0zEPeJL9CKh51gZNeuF0jaRqEXD3K4ufHrI3CZ4
 9TkgrOE4BkMjxOEnC0z6zXsWGGCSA3sksmwUwpHihqBjswjTjGHrmf4GH0bB3d7N7U3/erXyY
 rr1tyNqtwiHwx10f85cM1aiXTc6948AdjWOZdq6N7MUWbsO14aG2ArpaG9MxQa4Ip1cNREU1d
 SGhSa+W/HsTWiyJV1MfHQ9vIqia/Xlb275mCwSoCj2Rci9FYAEKHGWiODzLT7Rgu05VYhs1Ei
 tGjKqpapt8ygNCIpDNuxNn2glVgY65WjCUbk16Qov4IwWPIqgQLaQe4fp3stI/4jz1xW7RczA
 PQg8MDYf353lSeUOtweKLYEJZ7GS6kB2fA3f5o/9eP647J2bZ6l//CnmDyHvHUzzvKtA8ddGI
 nDIVs7ZTsmCXdiv21wGj9YFhGYT8CJNxoly9+KHSa/iirJ9p6Pz46TvpfVe9yjtES7zNSWgZP
 grZSzqK6ygRvC5IW3lTkx2vg==

On Tue, Aug 20, 2024 at 08:35:18PM +0800, Jinjie Ruan wrote:
> Use the devm_platform_ioremap_resource_byname() helper instead of
> calling platform_get_resource_byname() and devm_ioremap_resource()
> separately.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Looks good to me, thanks!

Reviewed-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

> ---
>  drivers/spi/spi-wpcm-fiu.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-wpcm-fiu.c b/drivers/spi/spi-wpcm-fiu.c
> index 886d6d7771d4..47e485fd8f84 100644
> --- a/drivers/spi/spi-wpcm-fiu.c
> +++ b/drivers/spi/spi-wpcm-fiu.c
> @@ -448,8 +448,7 @@ static int wpcm_fiu_probe(struct platform_device *pd=
ev)
>  	fiu =3D spi_controller_get_devdata(ctrl);
>  	fiu->dev =3D dev;
>
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "control");
> -	fiu->regs =3D devm_ioremap_resource(dev, res);
> +	fiu->regs =3D devm_platform_ioremap_resource_byname(pdev, "control");
>  	if (IS_ERR(fiu->regs)) {
>  		dev_err(dev, "Failed to map registers\n");
>  		return PTR_ERR(fiu->regs);
> @@ -459,8 +458,7 @@ static int wpcm_fiu_probe(struct platform_device *pd=
ev)
>  	if (IS_ERR(fiu->clk))
>  		return PTR_ERR(fiu->clk);
>
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "memory");
> -	fiu->memory =3D devm_ioremap_resource(dev, res);
> +	fiu->memory =3D devm_platform_ioremap_resource_byname(pdev, "memory");
>  	fiu->memory_size =3D min_t(size_t, resource_size(res), MAX_MEMORY_SIZE=
_TOTAL);
>  	if (IS_ERR(fiu->memory)) {
>  		dev_err(dev, "Failed to map flash memory window\n");
> --
> 2.34.1
>

