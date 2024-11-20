Return-Path: <linux-spi+bounces-5762-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C9B9D3631
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 10:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD3D283AB8
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 09:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F36185E50;
	Wed, 20 Nov 2024 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7Q7gOiF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CDA17277F;
	Wed, 20 Nov 2024 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093272; cv=none; b=hXfOoFeRieGcGWhtibqfer3c2kZFWnPKYXmFD9Do9MbGHBsvu2K7BTurXmSHj9GZ9s2LwzYRCNHwF842TSG23k6wICUYxYprCtbiHj/KAU1l+3C1r4CKhrPkZa8Mp73gWhCQ3KjOj97PdMsGWCbYiK5VlZyM1KQ+GRUfP6lFsNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093272; c=relaxed/simple;
	bh=cXF+85jJaXoTpaetQcfN+ouYOFAfHJvV0CrdvqEAJWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5Cu5rpRDmCt4uyK8vkURRppscA0y5F2BUQv2Hy2AHxWQXBxYQvkCAaT5CpGmLgeBvHT5bISiZg8INitjyb6kSxKnlSR5G0aSUZEkwM3vNNU9J1Vgy5DR+cuOd3mYgoxQG8IXBm7qpdP36bdsRD134hxUSw3dmNDz0b+7bNe1wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7Q7gOiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409A0C4CECD;
	Wed, 20 Nov 2024 09:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732093272;
	bh=cXF+85jJaXoTpaetQcfN+ouYOFAfHJvV0CrdvqEAJWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r7Q7gOiFKqHq29LdQjzhkBkVjanwxYRRhyiY1zRfG4Ap4lhzKiuuoGvs2nhiWWuuC
	 F+U9PPetCiJdR/CtyG2H3T6VuAz2mZNzmZB2LW630ugkQOTzcVwUWZkr4txVej/kLQ
	 oaCOzBB4K6hP6CDmw5o0NND4yOHaFZArpTXhJHrR6hRdmdDkYR7oFGX2LduZFFfge5
	 ilEeYps1apekLptPxR7pr4Z2whma4cLEyaS8T6iCYknohmyOL7lfKrgmVvkoCfJoZ8
	 eRLL824FKNGCeYKpYWvvh5u67mdjLaU1EHSbV79VzGqZm8eJv3LoeTpcW0ecyO/eNu
	 FTg3Su8R/hsbw==
Date: Wed, 20 Nov 2024 10:01:08 +0100
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
Message-ID: <uskwi3uzowtbm6o4y2blcnktacvymasf53ppzxg5su4shvt6e6@bpuejjtwuczw>
References: <cover.1732030972.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1732030972.git.Ryan.Wanner@microchip.com>

On Tue, Nov 19, 2024 at 09:40:06AM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> This series adds support for the SAMA7D65 SoC.
> 
> There have been patches in this series that have been tagged as
> Reviewed-by or Acked-by, I will link these threads below.
> 
> 1) https://lore.kernel.org/lkml/20240829-sama7d65-core-dt-v1-1-e5d882886f59@microchip.com/
> 2) https://lore.kernel.org/lkml/20240829-sama7d65-sck-v1-1-3e7b19e3cbf9@microchip.com/
> 3) https://lore.kernel.org/lkml/20240829-sama7d65-next-v1-1-53d4e50b550d@microchip.com/
> 4) https://lore.kernel.org/lkml/1da0abbb-94e5-42fd-a2d2-71d5d7d253fb@microchip.com/

Merging everything into one thread makes it more difficult for
maintainers to apply patches. Some maintainers don't like cherry
picking.

In any case, this is at least v2.

Best regards,
Krzysztof


