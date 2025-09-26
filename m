Return-Path: <linux-spi+bounces-10314-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C03BA5247
	for <lists+linux-spi@lfdr.de>; Fri, 26 Sep 2025 22:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5C64A69BB
	for <lists+linux-spi@lfdr.de>; Fri, 26 Sep 2025 20:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15461283FC9;
	Fri, 26 Sep 2025 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWDsrBMW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E584C281366
	for <linux-spi@vger.kernel.org>; Fri, 26 Sep 2025 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758920210; cv=none; b=NViLo4O8dH1UtqNIVzwRCYP7B/kWy7i3H/yBjDl6x/qYBtZTJCb2yTWythSumNpJuaJPBbOGac6YvyX8ljiyVEVwGyhKhahosVn7rY21p8uNZojkI+V8Vn5fdbrlR8HSyBPCKe2rWdvohrcNxM90cCUfghUN2/73dwTqTb1fNHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758920210; c=relaxed/simple;
	bh=Cw1X1mEeEqvAQWhsxg2iLNOZrTNoNcGqgmpxA+jEQWM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=sp6tW4m7lSynOtZr3PygPtZd08ObiKy+73uMszAobVTjH9Yyn5YM1HcXKjbjKOt0rNIYq5GoqM2s9ZvCHNOmF6eBguHHh2xyCBirUictgveYwGorY01M085J9HaapveM7G0Z2buRAt4al9ylZj+g33xfg+Zj5m72FSnWBVw3ixs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWDsrBMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762DCC4CEF4;
	Fri, 26 Sep 2025 20:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758920209;
	bh=Cw1X1mEeEqvAQWhsxg2iLNOZrTNoNcGqgmpxA+jEQWM=;
	h=Subject:From:Date:To:From;
	b=AWDsrBMWg0MExOWmvOgGK5rr1ZoV5CWlznvnycAiRX6ayt2FUn0RpPYBa5yOSe4F2
	 cv1oDdO0p3MHCTMsXhauObmFosnZP4y7uiqRseP1YoJt9GvELgInaGU+PML2l1aQBZ
	 ilgJM3C2tupvv7v/umYjf4WKP9352jMqMlqYguSIToIpHvaglrE+Wyo/fkOLOYlvqT
	 a43zHdwW8PI5ohs3bKlG6hwKj7TrwtMnDmZCjH1ykD1Xp++P3J+3HnmmSonl62jQoR
	 ovgCcfLeDCf0ZQXJGIh4WbIvLhzqXKV9jA+Rn5h7IMgBzy+98DCitoCzeIMuoVv6dG
	 BDabzpOOOdOXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B18BF39D0C3F;
	Fri, 26 Sep 2025 20:56:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <175892020425.55711.1166361462284338651.git-patchwork-housekeeping@kernel.org>
Date: Fri, 26 Sep 2025 20:56:44 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Add SPI offload support to AD4030 (2025-09-26T20:37:48)
  Superseding: [v2] Add SPI offload support to AD4030 (2025-09-18T17:37:03):
    [v2,1/8] iio: adc: ad4030: Fix _scale value for common-mode channels
    [v2,2/8] dt-bindings: iio: adc: adi,ad4030: Reference spi-peripheral-props
    [v2,3/8] Documentation: iio: ad4030: Add double PWM SPI offload doc
    [v2,4/8] dt-bindings: iio: adc: adi,ad4030: Add PWM
    [v2,5/8] iio: adc: ad4030: Use BIT macro to improve code readability
    [v2,6/8] iio: adc: ad4030: Add SPI offload support
    [v2,7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216 and ADAQ4224
    [v2,8/8] iio: adc: ad4030: Add support for ADAQ4216 and ADAQ4224


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


