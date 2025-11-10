Return-Path: <linux-spi+bounces-11149-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58928C4928C
	for <lists+linux-spi@lfdr.de>; Mon, 10 Nov 2025 20:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06B53A3CB7
	for <lists+linux-spi@lfdr.de>; Mon, 10 Nov 2025 19:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACF833F36B;
	Mon, 10 Nov 2025 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E884fINJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E58337B80
	for <linux-spi@vger.kernel.org>; Mon, 10 Nov 2025 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804647; cv=none; b=krMozLW7OGPUfEAJwTL9AvPDwO/0Z6XblcbA0y4tCfYicQUqlgqkOqn3vlgBC32TqDduIngvE1rvQUIX3xbbZFeb564KlWsVlp2TQOIkSMgk4g2PvJ2nKLi9P3m0QXNSK2kXgoOimtWhHJcv3ZAVM9jBd4jWXdV47SD2N+YlLIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804647; c=relaxed/simple;
	bh=FTloUZDPxNn2RCzhqkqZMjMs+7EJQFv3MV/s3vhJTZk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mRuSd5lUTHTQ8vrXKz/knxMj9cWkR7yO4xnBWEOVehqsHVsuE2z1MMzjIltKgAntgdoqezxwnYSPLfYC1CKdveLFn0k3PIjFyYDt/2myB29co0/7duUgigMFqM8EAOal9PH8ba2EKP+0yXh1NKED2uf8PVKICzqmGMJMqwWynhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E884fINJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14306C4CEFB;
	Mon, 10 Nov 2025 19:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762804647;
	bh=FTloUZDPxNn2RCzhqkqZMjMs+7EJQFv3MV/s3vhJTZk=;
	h=Subject:From:Date:To:From;
	b=E884fINJMA/a+qeWInUQXhczSGmqIhHgPTpqnw0vy63jNljjjjD7KzvT1Wgixudyt
	 mIXyz2+iYbmals6EIOWzQ9SDSzL70NMHqG5yYCIQ+Chpn3IPMQJWhufUROscw9N0v3
	 wRZEnNAf8ptERZJ7i1ZTNnuxN9jXt/EVpLQ/CdDVTT1wuOz3iPjoGTD2Uy3VGHk9Qu
	 pac5elNC9fo/pcBnmBWRsQhnHrFuZFwjchiw4WZvosqLMWsFeh9uOwldQqJ5+hQ0pF
	 YHKqBA4U98YIOaZt5tNnINejjIQw9xk5kF/K5uZkr/k2W/ldN+lm4Y3dYSeiHPlkIa
	 S2N6dVD6XRxDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB9A8380CEF8;
	Mon, 10 Nov 2025 19:56:58 +0000 (UTC)
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
 <176280461753.2755844.15519942272809056749.git-patchwork-housekeeping@kernel.org>
Date: Mon, 10 Nov 2025 19:56:57 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] mfd: sprd-sc27xx: Move poweroff/reboot support to the parent MFD driver (2025-11-10T19:08:57)
  Superseding: [v1] mfd: sprd-sc27xx: Move poweroff/reboot support to the parent MFD driver (2025-10-07T18:14:18):
    [1/3] mfd: sprd-sc27xx: Integrate power off and reboot support
    [2/3] spi: sprd-adi: Remove code for storing the reboot mode
    [3/3] power: reset: sc27xx: Drop unused driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


