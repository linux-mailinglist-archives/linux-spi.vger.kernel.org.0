Return-Path: <linux-spi+bounces-5759-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D71539D3618
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 09:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9544A2839A8
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 08:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FA818E02D;
	Wed, 20 Nov 2024 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8G/IvZS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698F1176FB6;
	Wed, 20 Nov 2024 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093120; cv=none; b=hW+NLnE7sFw109bglEyYhwwVqEQ9tidXynwBHOGMTYrM3SxcJbzIFBTaR5/G7oxkga/hzPUjVmWxOFLtweJCvjLfMQZ/bdLolpo7OtcL+oYDtKKlW+fEt3lYCs4umN+rqvsZ8op4Z5qc7Xh9zlDS7VltfTwGjsuLs6M2RLY2Eg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093120; c=relaxed/simple;
	bh=LkbTewK9y9FgQpIpn6FxzD8GeeGKuw9teOC1wFZlEIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8m5JppQ6RF4BSTePVxDINBavwJFWpJ55ax9HqnOKXuipSO3FEaI1oEC6QNzGowIDR6kDHVYq0i/caFvAZdpu5XPz4vub38E0oXdHt1taPondrNKBi0yekuEq41ewND/q+CE9W6Ikv7bF5peMAcLktGi9MQtEFgb81uDD9Cat3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8G/IvZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17523C4CECD;
	Wed, 20 Nov 2024 08:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732093120;
	bh=LkbTewK9y9FgQpIpn6FxzD8GeeGKuw9teOC1wFZlEIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I8G/IvZSeEN6SRunWHKDMW0hs6cXQs1BWbXrI6z3OftWVjB/fmT6KMeQatQrvhR3+
	 5p0VDfymfaotgM+ypHVfHhUKyORadIPW5MES6y4K//6PO87Hep9K5pqWyW7sbX68gU
	 SevZLn1H59aSuRygcWwm2YK8xy553fkK7QsVWUAItHh+ICdx6klIpFUEStqGWofVrl
	 9TGw1BTm8Q3e/VetHaXsdghZ32sLv5J5LkgD5yh+LD7gWyb4mRwyBuENYs95TCsTK1
	 ThbOkJU3EDMJgM+IcEWAAkkfAZZf2cj/G+uVIbnUXLsqbmxbVlrniLpTWx+n8g/m8D
	 AAL2G0GcI8ltA==
Date: Wed, 20 Nov 2024 09:58:36 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
	mturquette@baylibre.com, sboyd@kernel.org, arnd@arndb.de, dharma.b@microchip.com, 
	mihai.sain@microchip.com, romain.sioen@microchip.com, varshini.rajendran@microchip.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 02/15] dt-bindings: mfd: atmel,sama5d2-flexcom: add
 microchip,sama7d65-flexcom
Message-ID: <ce4rq6gefqrsaubpab573qi2r6ozagxvgjcdpslo32gvnxjapa@tbvdzcrsbmme>
References: <cover.1732030972.git.Ryan.Wanner@microchip.com>
 <46928aa2d15d05fa3046c270a51a10cd56c2e919.1732030972.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46928aa2d15d05fa3046c270a51a10cd56c2e919.1732030972.git.Ryan.Wanner@microchip.com>

On Tue, Nov 19, 2024 at 09:40:08AM -0700, Ryan.Wanner@microchip.com wrote:
> From: Dharma Balasubiramani <dharma.b@microchip.com>
> 
> Add flexcom binding documentation for sama7d65.

You also consolidate entries into one enum as preferred coding style, so
this should be mentioned here.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


