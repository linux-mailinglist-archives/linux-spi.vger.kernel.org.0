Return-Path: <linux-spi+bounces-6040-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23129EE104
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2024 09:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87BFB280A69
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2024 08:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D4F20C01E;
	Thu, 12 Dec 2024 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSm2RCRh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FF5126C01;
	Thu, 12 Dec 2024 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991470; cv=none; b=crTJNwP3xasPV0AMi5FFjHAReZ9CRm7hMI25X28KY+y8xdwo8kBdZ3Gre0G+N9ahwquPO+FvijkWWiNzRhW5UlX7X+kgjx0dP09ului1gIXBEViqdQHRC0eXqxV7bKdotQy/4qqEdXskHkS8zxqrKeIge/eMRlc3+ABJ0rb28fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991470; c=relaxed/simple;
	bh=9L8I21enfW9cEAjR+NIYJvYAjvbWbGI6CWCsEgxGvOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyLfBjnVN4vaBuVgcSM56ZWCxEWEy8GGbL4OMz9/P+CDG0vRItA5JcMb3lsNYt/8utP5aR/vSuX+qxZtfosHmHEQdSJWqIycJMUSLCJd+Pn+zR6E+L5D91SnYUhpIRmzJbCRXhgnZvcAi9qPzhsjZag4HqY4+uBZlSaTiSMgq2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSm2RCRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC03C4CECE;
	Thu, 12 Dec 2024 08:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733991470;
	bh=9L8I21enfW9cEAjR+NIYJvYAjvbWbGI6CWCsEgxGvOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tSm2RCRhyRfgXBimI0IUQRlYVDBL42c7/flr9mv++UgonqsjrKTnwFh0fvzwbdICJ
	 qfrat0q/51IMZaQYIcF/uNbbtrt1uhoOJSsq4W1R9Q8qfukE3VPFtlVFNpzaNRxN1D
	 fZ22f1Y+spDrtToReY5rQTYwTNJsE82ul72AEalx6nOHR8oSq/UgqoVwVtiXcY/BCV
	 Zrzk+D7JqiR2NhOUZ2HKK6vO5qFW7TVbzgc0EtbHyM02EkJ8eRHWwdBIeGgw8wGdCE
	 J1QJC1k4/lzBo2gfEQD3aduJLREZ11C7opg+gv1bJxHTfwarwpVRgW/SbpyiTKHR9r
	 TauA3NvxGedbA==
Date: Thu, 12 Dec 2024 09:17:47 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
	mturquette@baylibre.com, sboyd@kernel.org, arnd@arndb.de, dharma.b@microchip.com, 
	mihai.sain@microchip.com, romain.sioen@microchip.com, varshini.rajendran@microchip.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 07/13] dt-bindings: clock: Add SAMA7D65 PMC compatible
 string
Message-ID: <faf3547rv7easjc6rwewzn3xdp2y2zc4opsbqvhvsbi6e5g6fd@dkcdkiycp5op>
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
 <5252a28531deaee67af1edd8e72d45ca57783464.1733505542.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5252a28531deaee67af1edd8e72d45ca57783464.1733505542.git.Ryan.Wanner@microchip.com>

On Fri, Dec 06, 2024 at 12:59:52PM -0700, Ryan.Wanner@microchip.com wrote:
> From: Dharma Balasubiramani <dharma.b@microchip.com>
> 
> Add the `microchip,sama7d65-pmc` compatible string to the existing binding,
> since the SAMA7D65 PMC shares the same properties and clock requirements
> as the SAMA7G5.
> 
> Export MCK3 and MCK5 to be accessed and referenced in DT to assign to
> the clocks property for sama7d65 SoC.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


