Return-Path: <linux-spi+bounces-4682-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8D896DF0E
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 18:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0AA81C23F3A
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 16:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA69719FA64;
	Thu,  5 Sep 2024 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="czpFNO26"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE8619E82C;
	Thu,  5 Sep 2024 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552066; cv=none; b=fyjtuoluB0JFr4up2WwITSjFB/VEb3VAL2QrR6dO+Ibz+LJQ0tNMRMEm+e70petWE1wDBc7HK3W47L/Vy2SkQBAxEdl/1WJQjHG0muZYE0GJbUOvMIiW2FiyauHkyx9ZzZq+y0nZC0GoKl+pLYi8wGFjpPeggfL9i/P/9X594wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552066; c=relaxed/simple;
	bh=4lPMovijD49Zq4+o748R/nLVvhvNDXYslSK8l4YkqQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INMXYc6lnwD8IdHu1vjK8KjzRxB+KxCgs3Z0BtpOKELD/EEdxPV4VP5NCtzu/soIK3n8SNordBCEzftB4yE1TJMTphrpD/P6qcgUZ2IhHYcPQDgXW/mzroEjEjKILhtSpKMth5xAbLKl8RrV6MZQXQR4o3SW+qNv4F1ceeILtGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=czpFNO26; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1725552054; x=1726156854; i=wahrenst@gmx.net;
	bh=YYBJzQseASq4Pn+YxR4dTa4N1Kq79T6A7aBvavcJLVU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=czpFNO26SXbc0U3rZZT9vb/fy2Z05cIZjcANIbWMCe2sFhvgvhw3utKjKtnHVM1n
	 TwdsGkApha0uc4StdrhoN5Fh24fDJ6srpktHl2PyPJeOKN37uxPgu4eoORhESGDuX
	 ZKNmC+KdsRNtx4PJoFX5jJOXr6JvRYRcNJYd7fEOhn8gCKdcitTyrLIft7l9wPnFg
	 ESYvfbWTzodmRBQbI7WDEhZXotlJ6sqEOd5xQQnEegg6yMgaCEGvWjmdP9W/iUQ+3
	 JLZ1xb7VNX4niff6vAQCHTNWQYuYweR7iFSK7gGblUZDCWNj4KN5NdN3O4oREOckp
	 POFsmiIgJ70Ljd0m1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6qC-1sKdr81TkS-00ZVHz; Thu, 05
 Sep 2024 18:00:54 +0200
Message-ID: <54d7a5c6-caee-4d96-9943-fe34599eaceb@gmx.net>
Date: Thu, 5 Sep 2024 18:00:53 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] MAINTAINERS: SPI: Add mailing list
 imx@lists.linux.dev for nxp spi drivers
To: Frank Li <Frank.Li@nxp.com>, broonie@kernel.org
Cc: carlos.song@nxp.com, festevam@gmail.com, imx@lists.linux.dev,
 kernel@pengutronix.de, linux-spi@vger.kernel.org, s.hauer@pengutronix.de,
 shawnguo@kernel.org, linux-kernel@vger.kernel.org
References: <20240905155230.1901787-1-Frank.Li@nxp.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240905155230.1901787-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:BxbXa4uzCsEspAuqJbQaSPwkzrAeA2+cWSKhxsIKpx+xXj9FaTE
 zmjnPgYbbDA6eBC266ZUDgwGf5pLeBKglkuSB/mz9v+OPXvZ0XzAJsKa4ydri0BPIKhzFKW
 BO2vbXW72cCe3bypqlmBif5MQM5zh1ymnNWwbjszLwbtXyUSb6izlFZ+v8CJDQZ+7qgRzEc
 rWs+F9VOsadIxRtp4alcQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aOBrPQXgmtw=;zjLeUPqcWcssS8VYMHDn0gODPxa
 siCTLBga/IRWdMCK0nOTjV/8LsyglC7+1T3DUp8eJTHRD43ijkyIMW4BAUnbeZMQjfsAao3Ak
 Ybgegq5FX7axF36+6EfXxxkFzKgRjIa5xEo0oFgotuCWJlOe3KjHeOXWUIxwrtvhm6t3ihipF
 2vL6OWX4IWuqfZCCBGWD0lGCbu3e/EvsTpe3CbmdPydC0SJQjt8agerJ8TPw6YVn16m/C4CXA
 e1O9efnZVaDI2QVYiPArL/me8OFIpm4V1PtAaKjE/l1IZTnNThH3ZmYewKqaRLyZ3CFWOJLIk
 N5f9U17vOPdZc/eji1m/An4F4bTu42gbNqs5hANTNWo/4NqXhl0KeXzZf5Ap08UdsLGdKJLpb
 e7y7bXEmi7hBG202ioNk2acTgF5WOb9Q0H932UoRBsnPQKH9WE05VVXTqgq6GdMcD8XFyc/Wv
 f/ZTkPtVP5GkY13IRWq/OxX+yDx+AKCudjYyUZ1wpvFVrrJ89nJrENI6lmJA75yTxeSfwN8+H
 PEzgQFs79QVPiMGz7u9ikxCmEpNl/fHD/JETtfsvsAEWX52wZD0uhHtDJyXaPMMpUQPl7eTz9
 3WnBTVroOu4dur8OGzSWvC8RwW7NjicOmfpD1K+/wviWismA/N4MUzJDXoDPMhau2kFaPO0Wh
 uI7eoUEEUcf6pt25Yh4cCYT2+cTONFst+zKZA+uWqEABF+VAGPVcvFd/2mn5zmwDvlrrzn9Ao
 b944hsRMoMUcTAi5n0eiz3CjQ2KJK+EdET3V4wxYPk6X6Y5aHJ515QEnoFmx6JVZBkal7oNRl
 mFrYrxxdyadoDqNMkhP6EzGA==

Am 05.09.24 um 17:52 schrieb Frank Li:
> Add mailing list imx@lists.linux.dev for nxp spi drivers(qspi, fspi and
> dspi).
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>   MAINTAINERS | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 59eb18b0261fd..8900c53ae66ed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8958,6 +8958,7 @@ F:	drivers/dma/fsldma.*
>   FREESCALE DSPI DRIVER
>   M:	Vladimir Oltean <olteanv@gmail.com>
>   L:	linux-spi@vger.kernel.org
> +L:	imx@lists.linux.dev
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/spi/fsl,dspi*.yaml
>   F:	drivers/spi/spi-fsl-dspi.c
> @@ -9086,6 +9087,7 @@ F:	include/linux/fsl/ptp_qoriq.h
>   FREESCALE QUAD SPI DRIVER
>   M:	Han Xu <han.xu@nxp.com>
>   L:	linux-spi@vger.kernel.org
> +L:	imx@lists.linux.dev
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
>   F:	drivers/spi/spi-fsl-qspi.c
> @@ -16562,6 +16564,7 @@ M:	Han Xu <han.xu@nxp.com>
>   M:	Haibo Chen <haibo.chen@nxp.com>
>   R:	Yogesh Gaur <yogeshgaur.83@gmail.com>
>   L:	linux-spi@vger.kernel.org
> +L:	imx@lists.linux.dev
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
>   F:	drivers/spi/spi-nxp-fspi.c


