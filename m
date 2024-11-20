Return-Path: <linux-spi+bounces-5765-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 559CA9D365F
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 10:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA951B21E66
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 09:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E6C189BBF;
	Wed, 20 Nov 2024 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shP2YrDa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59092136A;
	Wed, 20 Nov 2024 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093553; cv=none; b=PBqaiMu75tAntC8jzyz8k19Tkmhhuzynk9J6emIOBbguH7IFW4rPc8qqF6PvmiSUEEjE/1JubVoryimo1NP8jyC0kfG6623VI1D6kLuYkQz6v0cLergIT9140kUxHws8cESmKROBxalwAFVAfAvIybX0ql6jAYC1yXDlbeEQJdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093553; c=relaxed/simple;
	bh=WO8hLANsPSWfDRTdCVZPGdNfpBAAEwfxq1h8xg7OMPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Farla51M3t9mAGY5m4I8UneMrxyQzJktAmTg0hRduJAnzH6ldnQCz8n9cojU2KIKzZ0VhjUx4s7uOQttw0va1qBJ4ejld1U9I8EtXw9YLZ4SySZ049XLkXIXlVCeG3eO508/F7S9sHphMpmm9k+pecBRznNa2iTh/srQzSQb4fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shP2YrDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AF6C4CECD;
	Wed, 20 Nov 2024 09:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732093552;
	bh=WO8hLANsPSWfDRTdCVZPGdNfpBAAEwfxq1h8xg7OMPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=shP2YrDa5nyalGUXibhQWcwYsUUNXbIj4uyAddSvqI5tmNh5dCNMhtiD/aGVjDFHU
	 YM/VgyV1Gh3MJKOWEyXgKw+p/xPIpDctrAEO4ZxmR0XSLmX40tWuhDV4Y6jRFOr95M
	 TZ2yas7y5h04TMGAdjLnxRGHPtKIncbiezxSDI/AuFiLPLhdTK0Bh0Lvfxo+RWTiaY
	 DUajAqUNQtIvsjTlwVKFxmVlGyE43h8D6FSWbUQGhzQqIkldyPQR1/o6Tpds1Ay3XW
	 5LsRiDQ4PWxBmfJ/A/44Ft/GF9ZCOoMwm58G2wEQtfTMuhIV1SxeVIz+cDvJc38m3I
	 vVH/iGeUNsztw==
Date: Wed, 20 Nov 2024 10:05:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
	mturquette@baylibre.com, sboyd@kernel.org, arnd@arndb.de, dharma.b@microchip.com, 
	mihai.sain@microchip.com, romain.sioen@microchip.com, varshini.rajendran@microchip.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 00/15] Add support for SAMA7D65
Message-ID: <qfdr5ef6dc4v46x5bhuz4smyxfwreudmaou557s6be6ipejbyv@g62lm3syt2rf>
References: <cover.1732030972.git.Ryan.Wanner@microchip.com>
 <uskwi3uzowtbm6o4y2blcnktacvymasf53ppzxg5su4shvt6e6@bpuejjtwuczw>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <uskwi3uzowtbm6o4y2blcnktacvymasf53ppzxg5su4shvt6e6@bpuejjtwuczw>

On Wed, Nov 20, 2024 at 10:01:08AM +0100, Krzysztof Kozlowski wrote:
> On Tue, Nov 19, 2024 at 09:40:06AM -0700, Ryan.Wanner@microchip.com wrote:
> > From: Ryan Wanner <Ryan.Wanner@microchip.com>
> > 
> > This series adds support for the SAMA7D65 SoC.
> > 
> > There have been patches in this series that have been tagged as
> > Reviewed-by or Acked-by, I will link these threads below.
> > 
> > 1) https://lore.kernel.org/lkml/20240829-sama7d65-core-dt-v1-1-e5d882886f59@microchip.com/
> > 2) https://lore.kernel.org/lkml/20240829-sama7d65-sck-v1-1-3e7b19e3cbf9@microchip.com/
> > 3) https://lore.kernel.org/lkml/20240829-sama7d65-next-v1-1-53d4e50b550d@microchip.com/
> > 4) https://lore.kernel.org/lkml/1da0abbb-94e5-42fd-a2d2-71d5d7d253fb@microchip.com/
> 
> Merging everything into one thread makes it more difficult for
> maintainers to apply patches. Some maintainers don't like cherry
> picking.

https://lore.kernel.org/lkml/4962c133-50e7-4d3f-998a-b8d853ab1425@kernel.org/

I asked to put bindings with its users. Primary user is the driver and
this is explained in submitting bindings patches document.

Best regards,
Krzysztof


