Return-Path: <linux-spi+bounces-1627-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 419E48706BA
	for <lists+linux-spi@lfdr.de>; Mon,  4 Mar 2024 17:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06EC28D661
	for <lists+linux-spi@lfdr.de>; Mon,  4 Mar 2024 16:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F2D487BC;
	Mon,  4 Mar 2024 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="cjo+/8JL"
X-Original-To: linux-spi@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B314CB24
	for <linux-spi@vger.kernel.org>; Mon,  4 Mar 2024 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568941; cv=none; b=H+d3KTfbT7FDPHCoiSAI1puzU9sJJc+p9F10vT329jL0ZRY5RTn/9EhfHWvLdEVQGf/3Yu5l/5E/KnvKRLRngyOdODdnI4k8WOG9a8j22SRlpVAo9lXdBwai/ffDJ3EFgH1GyEWb23rb+E/J1Jc19OOsN6snjgTdLzzktZe/vn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568941; c=relaxed/simple;
	bh=4wLXXGapyhl5RXVihnd+1Vp73lXL989wXTA0Ag/ZZ1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JNX9S/w2jhunijPlUH04U02NA7vEbr6+Gmp/B9CSRNVZYPtTKS9ZtjzYseQUVI28f8HEsIhkbGUE6PZy9YwFQDnFpz29cyYV5XZzdj4V5dq144Nw3BgX91ktGLSAFBWRUvw43zODHaGDD8LfmI3AWm+KgviY7/f5M+SgILdZ+lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=cjo+/8JL; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id h24rrRg7WDI6fhAyUrLLcD; Mon, 04 Mar 2024 16:15:34 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id hAyTruOYA2Ka4hAyTrR29J; Mon, 04 Mar 2024 16:15:34 +0000
X-Authority-Analysis: v=2.4 cv=JvP3rt4C c=1 sm=1 tr=0 ts=65e5f3a6
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=cm27Pg_UAAAA:8
 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8 a=dPq7nFLFEyjAz7fAJV0A:9 a=QEXdDO2ut3YA:10
 a=xmb-EsYY8bH0VWELuYED:22 a=IawgGOuG5U0WyFbmm1f5:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8i2X/bWggq1yfpDbyb2kwdQL3S/U6M4BjzbCsEE+miw=; b=cjo+/8JLIpVVj8RUICChZHzoqx
	XXKQHmpHQAnC4UKC22Bzg3n3eQAxaGzntF0h93IIp5KmW76LC4kmoFYtfpZ4DoKPBfbaEU/HSzDlC
	0Az9mOjkHScrMgK9+GAQZkGPCbt9pPZ98pd6Hgx22tlzFx9ACS3Dj0wWDfW3NkKGLEycgMuPmuh2C
	PB6l9QtHvw81goFu5ndmwwQgCba4oWVx4ET4jtN7zK/8lL6rNRZPjjzHWCBXHAyGQqEAPUOon2PfZ
	heb9iFidHHfE5WC9B0AOv1ivBcu0OnixBskO2P99oWtspbIvSwk7dVkbzHHqBZZBSNgeWrnPzT24d
	nW72FOfA==;
Received: from [201.172.172.225] (port=49252 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rhAyS-003iEz-30;
	Mon, 04 Mar 2024 10:15:32 -0600
Message-ID: <8281c9ed-8532-40c3-ad5b-3c7955935705@embeddedor.com>
Date: Mon, 4 Mar 2024 10:15:26 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] spi: axi-spi-engine: remove p from struct
 spi_engine_message_state
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240304-mainline-axi-spi-engine-small-cleanups-v2-0-5b14ed729a31@baylibre.com>
 <20240304-mainline-axi-spi-engine-small-cleanups-v2-1-5b14ed729a31@baylibre.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240304-mainline-axi-spi-engine-small-cleanups-v2-1-5b14ed729a31@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.172.225
X-Source-L: No
X-Exim-ID: 1rhAyS-003iEz-30
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.172.225]:49252
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDH+LpPLj9kjaPy1jsmY6Xy7PKZc+zuwj/+M2WWBwY+wPjm5PDA9sq1n7qYSkywKWo9uVDX2bcnGOXEnvt2b1bk9QPIddh3QwReN50zVWz/dt+vNvD5f
 adg5vl8jgGglp/C0/2sFbOBQmwAW3Uq4+naEQUcYzmRUXX2ca1EutXqC0hNqN7hgdCQeHL5z5ZNkjkfU6iJw4a1cKJbaRRgJxH8=



On 04/03/24 10:04, David Lechner wrote:
> The program pointer p in struct spi_engine_message_state in the AXI SPI
> Engine controller driver was assigned but never read so it can be
> removed.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/spi/spi-axi-spi-engine.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> index 6177c1a8d56e..d89f75170c9e 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -82,8 +82,6 @@ struct spi_engine_program {
>    * struct spi_engine_message_state - SPI engine per-message state
>    */
>   struct spi_engine_message_state {
> -	/** @p: Instructions for executing this message. */
> -	struct spi_engine_program *p;
>   	/** @cmd_length: Number of elements in cmd_buf array. */
>   	unsigned cmd_length;
>   	/** @cmd_buf: Array of commands not yet written to CMD FIFO. */
> @@ -543,7 +541,6 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
>   
>   	/* reinitialize message state for this transfer */
>   	memset(st, 0, sizeof(*st));
> -	st->p = p;
>   	st->cmd_buf = p->instructions;
>   	st->cmd_length = p->length;
>   	msg->state = st;
> 

