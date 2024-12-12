Return-Path: <linux-spi+bounces-6039-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 147FE9EE0FE
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2024 09:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B24E164A2E
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2024 08:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7BA20C005;
	Thu, 12 Dec 2024 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dU8i6Qv6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901D0126C01;
	Thu, 12 Dec 2024 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991451; cv=none; b=QynJHs5Dh1OFBvClrm8/fBkzf1tvBwka+3BvbHbcVIzMe36G1BKJLautpIMrG8qZguxf75NaZ2vLyryNFWPmEL0nWKPM++ffPfgGD0ADMwq4P/frK2ZvC6HN0BWV3totj9jnbT1BeMU8hNK1KdvkWSHb55/rs/twMHNQD7jt0V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991451; c=relaxed/simple;
	bh=k0FKOuDzgEVL7PpLLyql5QGBAf1lpNggxg9A2Cs/6gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DE7BHfEMQ6xz+e4bmBQt7wf6flk3gQQsZ7eJGdkbMWL+oPVbKIUbLwqMkIFF+99fSQIHnE1EvpnfHuthupW/1rmCMSDaj7tFeSP9OxPO+Ijp4GJ3vRyeu20uDm+ESQzBxQpQs4osUO+2ckgIv32F6hSgGlE7B2wV5Hz6TFx7MoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dU8i6Qv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6253CC4CECE;
	Thu, 12 Dec 2024 08:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733991451;
	bh=k0FKOuDzgEVL7PpLLyql5QGBAf1lpNggxg9A2Cs/6gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dU8i6Qv6AHW8QJDEe6c/rZc4kMHxuZ/sXsid0haVKb6BqAg2fZzGn/HILsGnBXLDk
	 JKhwLrxrVxoTts/73qlTnAUTUUmNZGpkTEKJNx/ugh70oRkCtMcIV1av4UgQeOayMW
	 PrwN8vGoH3uJY1YzeZpcanLDgEmNu3CvlA6zvP8IH3C56jGxQt+TeuJ8EzDgThGchc
	 q83iE1qlRAxAPDRTGvtMx97lwtVvogqMi5HuDJaiuD7XpUp8KmPVNIWYomP/FPhye1
	 GOzdlA4HUqcC17Ovv8gRefokYwG6r98t2ktCmWs3Vz7pmIf87Oz+Bu/hu5m/fcPr2l
	 fYLQcaO/y0Jng==
Date: Thu, 12 Dec 2024 09:17:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Wanner <ryan.wanner@microchip.com>
Cc: Rob Herring <robh@kernel.org>, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
	mturquette@baylibre.com, sboyd@kernel.org, arnd@arndb.de, dharma.b@microchip.com, 
	mihai.sain@microchip.com, romain.sioen@microchip.com, varshini.rajendran@microchip.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 07/13] dt-bindings: clock: Add SAMA7D65 PMC compatible
 string
Message-ID: <s77ndnhfnpssi4hynbf5n2ylkrhftnlfu37km5vpqbeb552w47@fhklcvdnwasa>
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
 <5252a28531deaee67af1edd8e72d45ca57783464.1733505542.git.Ryan.Wanner@microchip.com>
 <20241210164638.GA3770349-robh@kernel.org>
 <fb11338b-986f-4a9a-a0dd-e8f4e63941aa@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb11338b-986f-4a9a-a0dd-e8f4e63941aa@microchip.com>

On Wed, Dec 11, 2024 at 08:25:32AM -0700, Ryan Wanner wrote:
> On 12/10/24 09:46, Rob Herring wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Fri, Dec 06, 2024 at 12:59:52PM -0700, Ryan.Wanner@microchip.com wrote:
> >> From: Dharma Balasubiramani <dharma.b@microchip.com>
> >>
> >> Add the `microchip,sama7d65-pmc` compatible string to the existing binding,
> >> since the SAMA7D65 PMC shares the same properties and clock requirements
> >> as the SAMA7G5.
> >>
> >> Export MCK3 and MCK5 to be accessed and referenced in DT to assign to
> >> the clocks property for sama7d65 SoC.
> >>
> >> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> >> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> > 
> > Missing Conor's ack.
> I removed the ack because I have changed the original patch that was
> acked. Should the ack not have been removed even though the original
> patch as been changed?

Nothing in changelog says about changes to this patch. Nothing also
mentions dropping acks.

Please read:

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.

Best regards,
Krzysztof


