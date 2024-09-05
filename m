Return-Path: <linux-spi+bounces-4683-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BC496DF17
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 18:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1251F2504E
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 16:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E29919D08A;
	Thu,  5 Sep 2024 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Mpb1NaJh"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D4D19D06B;
	Thu,  5 Sep 2024 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552232; cv=none; b=FO8x6jvR29P/hr+mu53GoFM35kfqQTG+ZMQW0elpiaOwoLk8x8QgAsipS6/5kTh7puGr0ieKY4mHdNuJuvkQgkjJaB8v0J9WTljSjlR1CXMdXQGyRZnd1eXquuekO3whzIIt6fcZjBvlBNMa0FLY/6O5gQzKkayGtsMLsRpOMqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552232; c=relaxed/simple;
	bh=7bJFZ82V+SVB9fKa9IJb5wCjvKRsxxYfIFhPBD0BGsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qyx0xOgcPkQDNJLg9O6MZhQyzJEWEIlk0CM+60mlRuAXRPX8II8UDuGXziCwXo18dwtpoIcM1IhI5EGVYUvb72mIzeJVByyfqtGx6uztKFrOdCIExi/nJINeM9hwfJUC1/1bOBje4/wTvKegS8Oc5MNSSWkgAF0Yb6fmuViNg2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Mpb1NaJh; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1725552221; x=1726157021; i=wahrenst@gmx.net;
	bh=JUQaslPPfm+F4sp3kI63fsNwUQvBgfEY3iqev2sObkU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Mpb1NaJhDcm6Tmu9p4KodFOYP6hp+4SZyfnLprS85jp9Bq3PacXA1bVipGxCXzbB
	 5p8rKDCKWaMQuTC+9GdVk/skKZvlHc3ik/m6b9Vel5gZm3WaKKHTsxn5pHHdZo9HM
	 IWOJhO715qZuNqQLqFTYiW6U94AYHynX8pebmqBInc8l40yTjq3aZ4K94DzC0g5Fb
	 qY+lixiKQSB3q7cwoESHq97MXoiD7kcxZI8OxjcutJommEhoWlM3OH0UEzrCoVZqY
	 3VItckhmmGhXvD3eyqGLyLt4hKF/PNXWMDv2yVzqboD6TC0IpBaucnzC0tdIfAO2Z
	 NVquXblMFA0wxKHhnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsHnm-1rtatz2ePi-00tgUT; Thu, 05
 Sep 2024 18:03:41 +0200
Message-ID: <b2039039-ccde-4642-8ab2-1f92aa421ab3@gmx.net>
Date: Thu, 5 Sep 2024 18:03:40 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] MAINTAINERS: SPI: Add freescale lpspi maintainer
 information
To: Frank Li <Frank.Li@nxp.com>, broonie@kernel.org
Cc: carlos.song@nxp.com, festevam@gmail.com, imx@lists.linux.dev,
 kernel@pengutronix.de, linux-spi@vger.kernel.org, s.hauer@pengutronix.de,
 shawnguo@kernel.org, linux-kernel@vger.kernel.org
References: <20240905154124.1901311-1-Frank.Li@nxp.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240905154124.1901311-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WBNQoACSHWvqe+6q+DOzz+NS2eKv3MIzm2hb6IaC+gQ9AxfSyn3
 nd09N8tVa+YeyIrqOI0DOmWxB7RWqp/SitK7y8lBiOrQv/0KcFSXlcd1+EOlZ8Lq8X5+10D
 HL5zznlQRJtqVy6sFpvaTXhUhYqNGsHZ39ta2nsG86IEptTSRYW9cWL4jW+AYaRSNiZgxHx
 y4YuccpguRa1d8KTd5nDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3nhZf6hU6XI=;nCt+11puAeAqAfyNM56atojnB97
 aIzs1Ypey1hIOVjd7d366lohn17edQHdJlTG2xXoYkTcdH7Yf5Mt1MKgfF1/H/VBvbnCnkMhd
 ilIUB+wmSJEXqN78Qld81tYqx4trWsOemOlnLEjCDUUdBqisM3i067JjaMnBC/Qd8bJFNfSZz
 h4uR8WV82dROKgppWMADsD868fp7seGabm7Gi1wKL2IDcwrbb35G+7CmkgMcRA3aL+lqZnRW2
 GwhbhmINB0deH1121ZmH9DHjxxwc7Wl9WyfnlekZtK3kxpshtOAYZmZXf2iKINBVUZG/0cP48
 1GnwKcz2XRlAu4BNi0Lm1Q81EGiaz4o+6pxHGgBUljS9WhoRpwf5lwr39MbtNHcfu2B4sjM1N
 wbiIELHkzylKHivhary9rH507IIr9V5QqtiRVf5O9xE0aAaxi1TTDM4bE6wAXzC1J7fTLgIE/
 PDMKImkNxqV0845V+F7u4ABPoLAFzRgG2N1vNHQJoOjgL7ASl79mcN3ynWm4MO35f70AE37IQ
 GUK+aeV4ExyuW9696S3rEx5vST+ne0XxS8IUXWBetpi5oAcoW1d8UtLPsbe1AkHMSEkqIhsE9
 V1V5zk3W8H+Eq8CiqCLkwjsLSWLOHFJ8hVh6WidLNaVQv8fVeC3Cg1/lYz+yKobQBDigOPB6K
 mVrBH41MPbZcUXMYeuIG78nYsihvZv2cweGtItU9eTt9MZfjleoLH4kkRsutkTlS4rg0wbKMQ
 vAFMmKeti2pGaz+fIilSgCtHtChOQiIzhyeehWnnn2T6Z58zZ3gePvOFcf/AtvMS3xDTHHUE8
 +So8bCp975EauFSMuv2HomHQ==

Am 05.09.24 um 17:41 schrieb Frank Li:
> Add imx@lists.linux.dev and NXP maintainer information for lpspi driver
> (drivers/spi/spi-fsl-lpspi.c).
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

Thanks
> ---
>   MAINTAINERS | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 87c128de792b4..59eb18b0261fd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9042,6 +9042,14 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
>   F:	drivers/i2c/busses/i2c-imx-lpi2c.c
>
> +FREESCALE IMX LPSPI DRIVER
> +M:	Frank Li <Frank.Li@nxp.com>
> +L:	linux-spi@vger.kernel.org
> +L:	imx@lists.linux.dev
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> +F:	drivers/spi/spi-fsl-lpspi.c
> +
>   FREESCALE MPC I2C DRIVER
>   M:	Chris Packham <chris.packham@alliedtelesis.co.nz>
>   L:	linux-i2c@vger.kernel.org


