Return-Path: <linux-spi+bounces-10372-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0E7BAB1CE
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 04:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7A7167DB6
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 02:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1541F4CBB;
	Tue, 30 Sep 2025 02:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1Xx2ofn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486251A239A
	for <linux-spi@vger.kernel.org>; Tue, 30 Sep 2025 02:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759201009; cv=none; b=ebCIcJEDnl+O9GwTMtXt2kyOCDBhRzyVfIy7kxZ9Nw18WAqhWzC4ZpFNcXQ7cRCFP/eJ+aotOJ3m/sqWT+yGc6oqsoUkgUW4FVDlLQhR331Cy6B7haAAAP4pjGL9UdBfOy0/Q1EhcM9iKYMIwmFc7BQQEDFnrbSUbE4lPUa16pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759201009; c=relaxed/simple;
	bh=PpQMEugSjIE83+e4swUQ8bacifU9XV4MOc45xYe2di4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=XeJfDQUyKEto6AIQv1MAWaOnFWCm2s1w3c4/U1/GzN7Lbr77ln9oPmeC2C18pjnGny6D8p8l++Il9jNbMXRROIxmMTDAcBjvxF8JA1LVr26/zvf1Ilf+WKlx1jMu/P8TS5I4LcdDlf8tBDBxBVLuLyeZXHSMYkMPdCYtsjLx9Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1Xx2ofn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE47EC4CEF4;
	Tue, 30 Sep 2025 02:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759201008;
	bh=PpQMEugSjIE83+e4swUQ8bacifU9XV4MOc45xYe2di4=;
	h=Subject:From:Date:To:From;
	b=S1Xx2ofnunDmniAiDfkHNz/BMH3Ge0D0h388sZ1h+R8hY9vN51LK8Qeo6fv79mPDG
	 ErnEHkhgVH3aqi8yiW/tMna5aeRNVoagjTUGgKN4X7fJzbxeTW6Cf+R8k3BoQPs++W
	 nr3mAqLIplztculfVJRmx2ePhXrAf8h/mHmLExTJKAD0/SuIHXq+JJE2DhVj5NERZh
	 cvGlpwS2YVFn5Nvcpttr142AaVtg+0n71SV4TjpQzzTFiBWcZ4ZL+bCWgzA1OXXdlL
	 X6Ue7vBJonhq4azWPD1IHu/tFEcuJnTfrpm4pXXvJ8GXCJXyWDp6KN1KKRs8KtylzF
	 GftpfMfNXeSbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7107839D0C1A;
	Tue, 30 Sep 2025 02:56:43 +0000 (UTC)
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
 <175920100188.1805922.4451342333860830200.git-patchwork-housekeeping@kernel.org>
Date: Tue, 30 Sep 2025 02:56:41 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] spi: airoha: driver fixes & improvements (2025-09-30T02:26:47)
  Superseding: [v5] spi: airoha: driver fixes & improvements (2025-09-17T21:58:36):
    [RESEND,v5,01/13] spi: airoha: return an error for continuous mode dirmap creation cases
    [RESEND,v5,02/13] spi: airoha: remove unnecessary restriction length
    [RESEND,v5,03/13] spi: airoha: add support of dual/quad wires spi modes to exec_op() handler
    [RESEND,v5,04/13] spi: airoha: remove unnecessary switch to non-dma mode
    [RESEND,v5,05/13] spi: airoha: switch back to non-dma mode in the case of error
    [RESEND,v5,06/13] spi: airoha: fix reading/writing of flashes with more than one plane per lun
    [RESEND,v5,07/13] spi: airoha: unify dirmap read/write code
    [RESEND,v5,08/13] spi: airoha: support of dualio/quadio flash reading commands
    [RESEND,v5,09/13] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
    [RESEND,v5,10/13] spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
    [RESEND,v5,11/13] spi: airoha: set custom sector size equal to flash page size
    [RESEND,v5,12/13] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup
    [RESEND,v5,13/13] spi: airoha: buffer must be 0xff-ed before writing


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


