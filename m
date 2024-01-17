Return-Path: <linux-spi+bounces-490-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 320E0830513
	for <lists+linux-spi@lfdr.de>; Wed, 17 Jan 2024 13:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59861F2581B
	for <lists+linux-spi@lfdr.de>; Wed, 17 Jan 2024 12:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AF21DFDE;
	Wed, 17 Jan 2024 12:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="ONON1yhB"
X-Original-To: linux-spi@vger.kernel.org
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952961DFCD;
	Wed, 17 Jan 2024 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705493964; cv=none; b=UZ/0bU5+wasZTjfm9KbVjqR2lcGb/iYacDBifVBrQcR1PG+ZuSZvU+jITwxcMizQ+Jmmpq9H3N4U+sYjjfh3XHYOCLnq6JKiikp5t2SyV0qIK9Gq7v5F8jXatJcfAeabXV6Ny6+sfU+kYBAy5E67mm6HM4NlY1AE15I4s3SuaVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705493964; c=relaxed/simple;
	bh=1/JruNhQzvt4k2UwFQaNBd9PdN9vqyKXINQxzXFutKc=;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding; b=qV70RlrRkNgNSZ8neNDDWTlLzTLIx8sLFZ6WImPQLLG6Uzn4myKnTaPJQKN2oJL5lb9O8gKhe5SohaQ/YtZQesATA8Wr17vFiMD+j7K3oCAq4o2fDBLe0LjUH88FgcI220FkWtzs4tJxo+s85cu2tZJnZymZBPeFhUTjfnJXI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=ONON1yhB; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from [IPV6:2003:e9:d713:b66e:5a48:54ff:10ba:99f4] (p200300e9d713b66e5a4854ff10ba99f4.dip0.t-ipconnect.de [IPv6:2003:e9:d713:b66e:5a48:54ff:10ba:99f4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 36987C02E1;
	Wed, 17 Jan 2024 13:19:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1705493950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1N2x1Hkps2qGZwJZ4xfHmclD82tqsjiXAjGHBv60Z24=;
	b=ONON1yhBWZcwoPGBFHbnAYJ8T6CnGvmu/hZE7SCboEngZPCg3pnssKAr4WJg6kJS/PEL1j
	M0iejOxnn+3iCQfQFT0QFSZZYNTpnmEU34CxWAndCQKALgTL9QOyb81MnIxQK78zwal2Iw
	3222kwlaH9eQd7WRzRW4ofcIy9L4RS7wUuaKE8RWiZTGR2TVTJGnwKtnEJIvDxfmRY8qPc
	uBlykO93ivRQuzgfek+wyBkSYEzV0Y3kCXCn9b3FAGp9KyP+uUoetBAiPbArwNCGilcB7L
	uF97B4N7YKSi3Hk4pnAqKbNs/w3uhH24Q46MgIR5/E8H/zSRhG3eJt7JAbao7A==
Message-ID: <e572fb9c-00fa-4154-a434-89ad22e7cbf1@datenfreihafen.org>
Date: Wed, 17 Jan 2024 13:19:08 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/33] ieee802154: ca8210: Follow renaming of SPI "master"
 to "controller"
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, kernel@pengutronix.de,
 Alexander Aring <alex.aring@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
 <66d516d935840af55e72e0530029060ae4cf399b.1705348269.git.u.kleine-koenig@pengutronix.de>
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <66d516d935840af55e72e0530029060ae4cf399b.1705348269.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello

On 15.01.24 21:12, Uwe Kleine-König wrote:
> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
> 
> To be able to remove these compatibility macros push the renaming into
> this driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/net/ieee802154/ca8210.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index 4ec0dab38872..f732c150462b 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -2956,7 +2956,7 @@ static int ca8210_test_interface_init(struct ca8210_priv *priv)
>   		node_name,
>   		sizeof(node_name),
>   		"ca8210@%d_%d",
> -		priv->spi->master->bus_num,
> +		priv->spi->controller->bus_num,
>   		spi_get_chipselect(priv->spi, 0)
>   	);
>   

Feel free to take this one together with the rest through one tree.

Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>

regards
Stefan Schmidt

