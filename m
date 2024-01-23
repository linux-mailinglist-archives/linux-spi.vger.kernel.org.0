Return-Path: <linux-spi+bounces-677-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84696839A96
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 21:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79AC6B22A96
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 20:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DB7443E;
	Tue, 23 Jan 2024 20:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYrB9fKY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAEA5392
	for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 20:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043404; cv=none; b=bWkOv6/hW80mtd8poDlsr8BFIHJnNCESh3LWLxH4AK+Q/+tbtWS+mAW6CuaOFl4rrRBt8ZYjjfjJqOt/BgmaalKAXYa8380sw7wnZMuE+l58zwOGA2DwK2gPVwUnMhtwVMRF1ha1RjTl0ifjR21B+VW9bTSL6HYkQs7Cs2dSlWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043404; c=relaxed/simple;
	bh=i5aTHUslW44YzoPoZTzk7ldAWu/s5kNxu4pYLbrsfkA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kiYKbdqQ3NaU41TZt+qAfnbTsjX829qKeC6HAGWwdWmLvh3Rz+sw9TzNioOCNHYgIooS4GBdkOlu9voyrL8UMHQn7Ldggt3X/yUdm0keHN7SwEILXy2TBuPDpgk/m9TqGqRFECO+JAalB3l5n5TQcCwvMZ2CvJkpMmfat/7S1Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYrB9fKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56A1DC433F1;
	Tue, 23 Jan 2024 20:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706043404;
	bh=i5aTHUslW44YzoPoZTzk7ldAWu/s5kNxu4pYLbrsfkA=;
	h=Subject:From:Date:To:From;
	b=MYrB9fKY3nE9IfhM+IqTqBBVTjgbTMubUeVrf5nN4oJCmwS9NbVlaxhN14qe+qgOy
	 fQ6uWLY+9i/N7sl8V33s3vSGZxH13U7B72iLMqIOQ+EYZQSgect65B3++qV/KNcSXT
	 hbJ6CQr1hj8Qkhs8kMG/ZlinFgCMwH7DDeFKZjBc1jKnz9+Mx4n9jAz5Q/w2DIUT5w
	 6PqI2mIqpD4ao3wF581rQ+Zrh1BuhwC75S3gYWHo1EeDkHoQ6iRIQOawTZ6DvzkRDG
	 5nYhYiTGRmG+CBMm0EQ7wKlbAKy2Z8H1DWzuiUwJk0jSkBn2eP00mcONAdsmHg3F8b
	 lb9LWr8yidEjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42E50DFF761;
	Tue, 23 Jan 2024 20:56:44 +0000 (UTC)
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
 <170604340426.11276.14002602309802155785.git-patchwork-housekeeping@kernel.org>
Date: Tue, 23 Jan 2024 20:56:44 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] Deprecate register_restart_handler() (2024-01-23T16:44:39)
  Superseding: [v1] Deprecate register_restart_handler() (2023-11-17T16:10:01):
    [RFC,1/5] kernel/reboot: Deprecate register_restart_handler()
    [RFC,2/5] drivers/soc/litex: Use devm_register_restart_handler()
    [RFC,3/5] power: reset: gpio-restart: Use devm_register_sys_off_handler()
    [RFC,4/5] spi: sprd: adi: Use devm_register_restart_handler()
    [RFC,5/5] firmware: psci: Use register_sys_off_handler(SYS_OFF_MODE_RESTART)


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


