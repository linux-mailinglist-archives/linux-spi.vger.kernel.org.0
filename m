Return-Path: <linux-spi+bounces-10145-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DECB86560
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 19:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729D3566166
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 17:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101E6284B3B;
	Thu, 18 Sep 2025 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJPp4ho1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD2B283124
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218220; cv=none; b=LVEBAIhN5YESf+39rWY2F8vMR1xwtUh+O1xHP/wE32kNX9+kQLko1ZIJyGLXGLr/wgX5qjZPWX/U62s+WfGcYfR8tKDo+b9tGg6pW3X5VrPIU7XharnndQGucL+KJ0dhBGrUx252c9kOAbnTTlOLtgB5b6aE8W3rbmSFycMJ+e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218220; c=relaxed/simple;
	bh=pdC/CGXMm0tFhErXlPZ/b8m7Emu0a4j79RggwGgcUGc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Ok0FCXf9RkFoLATQOtZA0v8ngRnPKQBramhLe3PrTG7/tQZh0/K4xDg0JfzO+c+kFI1ttT8GtTX0EBOAxquPe5IKenSjaasrYFiFzCadihk4E0nfibKqBeovhKGY027uev+Fu20t4Ksyer83EJK/T5L48fNGfN0oDAfsd62AYPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJPp4ho1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7498DC4CEFC;
	Thu, 18 Sep 2025 17:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758218219;
	bh=pdC/CGXMm0tFhErXlPZ/b8m7Emu0a4j79RggwGgcUGc=;
	h=Subject:From:Date:To:From;
	b=nJPp4ho1thMbcXMRnUaFz+T+vUuGEzDHluXrqrFYapCoc/rpg2aPZ/vDEC0RaUChv
	 TtyPXiTfgfZ/b3Obx0LJznLinnYCpogof2VqNHUICz+RueoTFL7wjk65sma0avkWsC
	 SQWm16Sgkp18gm15FX50DKELzNYXmjOYCvnZdX3TUJWD+SHfHE3NingVY7J7iiN5lu
	 XVu5UhPfw3IhLtyaPy/WuHtjULjKuIci0dGlzcpJuY+XJrTUO3cJVC5DT0iwUZWsT+
	 aqeoDInxKlq4hwb7S8RjzaTj9/Xi8y1F+kY4Y91XHBJLDsB8z1WNrlRizjoqBSxAP5
	 A07dirwdduvhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE3139D0C20;
	Thu, 18 Sep 2025 17:57:00 +0000 (UTC)
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
 <175821821918.2518579.1695099229948123218.git-patchwork-housekeeping@kernel.org>
Date: Thu, 18 Sep 2025 17:56:59 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Add SPI offload support to AD4030 (2025-09-18T17:37:03)
  Superseding: [v1] Add SPI offload support to AD4030 (2025-08-30T00:39:27):
    [01/15] iio: adc: ad4030: Fix _scale for when oversampling is enabled
    [02/15] dt-bindings: iio: adc: adi,ad4030: Reference spi-peripheral-props
    [03/15] Documentation: iio: ad4030: Add double PWM SPI offload doc
    [04/15] dt-bindings: iio: adc: adi,ad4030: Add PWM
    [05/15] spi: offload: types: add offset parameter
    [06/15] spi: spi-offload-trigger-pwm: Use duty offset
    [07/15] iio: adc: ad4030: Add SPI offload support
    [08/15] dt-bindings: iio: adc: adi,ad4030: Add 4-lane per channel bus width option
    [09/15] iio: adc: ad4030: Support multiple data lanes per channel
    [10/15] dt-bindings: iio: adc: adi,ad4030: Add adi,clock-mode
    [11/15] iio: adc: ad4030: Add clock mode option parse and setup
    [12/15] dt-bindings: iio: adc: adi,ad4030: Add adi,dual-data-rate
    [13/15] iio: adc: ad4030: Enable dual data rate
    [14/15] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216 and ADAQ4224
    [15/15] iio: adc: ad4030: Add support for ADAQ4216 and ADAQ4224


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


