Return-Path: <linux-spi+bounces-10480-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0641EBC553E
	for <lists+linux-spi@lfdr.de>; Wed, 08 Oct 2025 15:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B974D3E2A27
	for <lists+linux-spi@lfdr.de>; Wed,  8 Oct 2025 13:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE488284670;
	Wed,  8 Oct 2025 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxzd71UE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA32E1E32B9
	for <linux-spi@vger.kernel.org>; Wed,  8 Oct 2025 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931814; cv=none; b=nIntwH2MPob7dcm119KTyTvjtvOL2RKHQfJtsLC3+MpyUMzaNrIjcNivrft26zo0uBsuVr31heVAziR5B7lBq+xueVqP42ENAMRGjfO4V8SEEY+FUU8/555bqqx42DpL7IHfdIXjqH+mx1kynWuqtb5smSAnM9JkcDPH4n/xrSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931814; c=relaxed/simple;
	bh=TLPt6JK4ShlOoR8+8igEzEIvs+MGmcCH50w10BCKP38=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=uptys9n5VhSCiCPeJt6+a7m/xR3BV98FcgwjXnTd8BAzGXd3qF/gVRngHRDuGVUZfRXQYyZf+bvelp/GMV5UQ2RceU4vlG2YvYbeW9YPnxKfHH8wvNzOVkF/oGcAdByZ8t457DLd6IGS3SMUROF7bFsVlQcequ0eEb+QDYl47Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxzd71UE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB26C4CEE7;
	Wed,  8 Oct 2025 13:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759931814;
	bh=TLPt6JK4ShlOoR8+8igEzEIvs+MGmcCH50w10BCKP38=;
	h=Subject:From:Date:To:From;
	b=lxzd71UEmb0uEitIlhL8uNn58DhLVVEZrmnZq87+/CzFfHZB1dBwnRJhB3+zebLGp
	 ga7RnV/uym3KluNVwqchjuYqkJ+C0EhcUh4xO0ailYbTDFzXEL8LxltwRFHzKRcD79
	 vYwi/IYVuDRJzErDmN6WHmVi1JhMaiBvjkgj2+LuHzo/j80F7IFuCdbqfJDSQCyI87
	 gd7NvZV4I7GSo+2uQoT6N2+7Q7F7gPHaGxrIDGNF2vwDdafzqFQMGMRgN7PZUo15+1
	 2ioYgJn8GY+CB3MZdq/+L1IGYTyfL9hltlz8AkIMp8QGolmPrOSkomIEcmUOjNZJwO
	 QxzMmyXTKh61w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 344FC3A40FF3;
	Wed,  8 Oct 2025 13:56:44 +0000 (UTC)
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
 <175993180292.3461265.7651556474249290427.git-patchwork-housekeeping@kernel.org>
Date: Wed, 08 Oct 2025 13:56:42 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] Add SPI offload support to AD4030 (2025-10-08T13:49:23)
  Superseding: [v3] Add SPI offload support to AD4030 (2025-09-26T20:37:48):
    [v3,1/8] dt-bindings: iio: adc: adi,ad4030: Reference spi-peripheral-props
    [v3,2/8] Docs: iio: ad4030: Add double PWM SPI offload doc
    [v3,3/8] dt-bindings: iio: adc: adi,ad4030: Add PWM
    [v3,4/8] iio: adc: ad4030: Reduce register access transfer speed
    [v3,5/8] iio: adc: ad4030: Use BIT macro to improve code readability
    [v3,6/8] iio: adc: ad4030: Add SPI offload support
    [v3,7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216 and ADAQ4224
    [v3,8/8] iio: adc: ad4030: Add support for ADAQ4216 and ADAQ4224


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


