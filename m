Return-Path: <linux-spi+bounces-10443-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AC0BC0EFA
	for <lists+linux-spi@lfdr.de>; Tue, 07 Oct 2025 11:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81D1188411C
	for <lists+linux-spi@lfdr.de>; Tue,  7 Oct 2025 09:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7191E47C5;
	Tue,  7 Oct 2025 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adbkP49j"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947931A9F8D
	for <linux-spi@vger.kernel.org>; Tue,  7 Oct 2025 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759831005; cv=none; b=fKw+6OtC/uWb8DbdNALwBVYxa9IywyUkCteUR0YcG8jdHuzKj/lNZxB4evJoxlIRGIcsAFYXFmMH4ugIh2rUFXHoY5b7WSHqmEPAOhmCVzcvxfBcxhqI2DIa/0YyRZrOZX3i8Bb2+sLEUVTRhN/OFEKjtauxQkzSl+9BX+XEsec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759831005; c=relaxed/simple;
	bh=XgRSwhHa3qU47Ogo9ZO253HrRAdrpaIx+kwxrTPvwmI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=TVEtwT3f0r2jRBbfgLBR+NVmm3PrzIiKEmceAVsRLVX6F55fTh97anrCT8zvBzAyp2eo1CTRglGXX4jbrxzBhfN0sBdfCBhBHvf1Bj3jO5SibZfWGL0ofRP9goNt+63YgTC6aF8HBYH39QlSKbUVRwbT5V48HyHjYs1nVPmMTVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adbkP49j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA4AC4CEF1;
	Tue,  7 Oct 2025 09:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759831005;
	bh=XgRSwhHa3qU47Ogo9ZO253HrRAdrpaIx+kwxrTPvwmI=;
	h=Subject:From:Date:To:From;
	b=adbkP49jySsonNpfdA6lgzC3xp1BhULH98pW6/4H1gjQgl5xG1jK3/WJjgH445VOQ
	 ZSl2Mg0ZghprvPWZRFNlo6uxyGX8f4koTiaAZ7hUlFDY35wP/8mT9B5xI4Rdr7tmUa
	 JDK3WoxJnA86YRLwIu91QfrYSjJq/qMncxtOKrm/0Ie0fKjKyqG71Q2B4c1KViBZyo
	 FwrxRjq1mypkMz49jlD451eXU6yY4FPX2R4vcZv73u4zg3FMHqd/fauHR9gfVoYTUs
	 gOOK4APOMFdYUaUPqciQn5hW3yQis9ZmUpp+vFOkiGj0c3woRBP3snY/ahpQxfUIfi
	 wjDoscQud+aeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEA7C39EFA5B;
	Tue,  7 Oct 2025 09:56:35 +0000 (UTC)
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
 <175983099430.1832638.11457327408600714592.git-patchwork-housekeeping@kernel.org>
Date: Tue, 07 Oct 2025 09:56:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] LED: Add basic LP5860 LED matrix driver (2025-10-07T08:58:01)
  Superseding: [v3] LED: Add basic LP5860 LED matrix driver (2025-09-11T06:59:30):
    [v3,1/3] dt-bindings: leds: add lp5860 LED controller
    [v3,2/3] leds: add support for TI LP5860 LED driver chip
    [v3,3/3] Documentation: ABI: add lp5860 led matrix controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


