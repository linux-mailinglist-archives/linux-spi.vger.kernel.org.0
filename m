Return-Path: <linux-spi+bounces-8975-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADE0AF0612
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 00:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958141C07F52
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 22:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C212376E4;
	Tue,  1 Jul 2025 22:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sa6bM5ds"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF06919995E
	for <linux-spi@vger.kernel.org>; Tue,  1 Jul 2025 22:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751407227; cv=none; b=TvyFy0rgpZ5phkqvmEZymxtgfbo07VyR2jY4eG5qJVAm+m7jyYAN3T2HMOZ4KxfXm1kcPRKNYVSneNu7BsjoWM5lwcJwRhA5q7lfmQRnbiQX23EzKX2WcL4CdK3dQhXAuU0H5NNiWjMyleVfqXJnVh/CLKxhFIQhVx9pb7JbGKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751407227; c=relaxed/simple;
	bh=d/mI48fKapkVo+QwnOivx2M4lbwdtbv/oLLtBYduOYQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=DXwRIiesZ8BQnpWC8oKdIoInbBCnHz6ntHdnYWWcwpohYqFpQYfG0TuYSoA/aSE85aoFwlNccFtimRTA5veYYL2eFrNX06NCHX3vRRbuCi19T/Ag3V6VT4ogo9Bj7LQQHUDqJxPVXzTNMB8pEEUTLIDFae5dqSMfzFhj1GzwGuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sa6bM5ds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A24FC4CEEB;
	Tue,  1 Jul 2025 22:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751407226;
	bh=d/mI48fKapkVo+QwnOivx2M4lbwdtbv/oLLtBYduOYQ=;
	h=Subject:From:Date:To:From;
	b=Sa6bM5dsxv/AVSwWNyeXBqNsaOMTDtM0qu06MK7ixpw9WqMluQg6dbBejU0Ir4iMN
	 1G1jyLlv1V/BMZ8LrKBvotW8PeH1n82o/Koj4MCsq0xi82RbB7bI/J+RbvmfuSM/Yp
	 vmvMs6Py5icdPT9qnfVQf/kde2zoC5bFwh/7NLQzQ0pCfwPMKGw6eiPzu+FpwFTQAo
	 2ISBY5kf++d4izDA7UUznSnCiddA7j4WFaeoHIYanVo4o/1wMaEFh3qZp/z9h1neBP
	 rCDb8P4E6znF/dRKF6oc4VkPCVmtcA1c8c89rWpEUC6mae6QpDpliGf+tZXf6co5FP
	 pGUWvJYYy/Fug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C6F383B273;
	Tue,  1 Jul 2025 22:00:52 +0000 (UTC)
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
 <175140725100.128055.12667715427713781596.git-patchwork-housekeeping@kernel.org>
Date: Tue, 01 Jul 2025 22:00:51 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] iio: adc: ad7173: add SPI offload support (2025-07-01T21:37:49)
  Superseding: [v2] iio: adc: ad7173: add SPI offload support (2025-06-27T23:39:56):
    [v2,01/11] iio: adc: ad_sigma_delta: don't overallocate scan buffer
    [v2,02/11] iio: adc: ad_sigma_delta: sort includes
    [v2,03/11] iio: adc: ad_sigma_delta: use u8 instead of uint8_t
    [v2,04/11] iio: adc: ad_sigma_delta: use BITS_TO_BYTES() macro
    [v2,05/11] iio: adc: ad_sigma_delta: audit included headers
    [v2,06/11] iio: adc: ad_sigma_delta: refactor setting read address
    [v2,07/11] iio: adc: ad_sigma_delta: use spi_optimize_message()
    [v2,08/11] dt-bindings: trigger-source: add ADI Util Sigma-Delta SPI
    [v2,09/11] spi: offload trigger: add ADI Util Sigma-Delta SPI driver
    [v2,10/11] iio: adc: ad_sigma_delta: add SPI offload support
    [v2,11/11] iio: adc: ad7173: add SPI offload support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


