Return-Path: <linux-spi+bounces-4835-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDA697A499
	for <lists+linux-spi@lfdr.de>; Mon, 16 Sep 2024 16:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13F51C220C9
	for <lists+linux-spi@lfdr.de>; Mon, 16 Sep 2024 14:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD815158540;
	Mon, 16 Sep 2024 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+ilH6ca"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C43156C76
	for <linux-spi@vger.kernel.org>; Mon, 16 Sep 2024 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726498627; cv=none; b=BsYpog5yqj2xlyCkGBn6XBn3ekJF3EH8IAfKGWTjVFbwz7ySTKpRHZ9wfpqSylW1UYdalr6zW/V4WXu3KG/X4+zf8K6pP2DaLfPAwA6auiQlVRP00XrXXmng0UhOtlkn6Vwo2oyXQIiWB25uCe5tX4SNSdUD5g6jxDnfEm71m80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726498627; c=relaxed/simple;
	bh=XBEXWvN8H7J/WkVzny9rSdseDUYI1JQzjyjtByVJ0lU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=oj7BdsOd/5qEYoRfa2mmgBylVGXtYC8Ua80oCldHSaVkm7PGwYzVPPwPZk9fftW4imBTBj+ASO8iApWwQ0cv5Y5maA/OGp94vR1Hq1iddchewFl/xFeXdQb2ZwynixOtLNS0DVMt857Vk8JJeCeIpLImnpCp5KoobAROfUaOmLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+ilH6ca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54ACFC4CEC4;
	Mon, 16 Sep 2024 14:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726498627;
	bh=XBEXWvN8H7J/WkVzny9rSdseDUYI1JQzjyjtByVJ0lU=;
	h=Subject:From:Date:To:From;
	b=F+ilH6car/SLMK1YNJ90gOj9NikOehk7dQwWVe1BhYRpjY6HK8v1X9OUT9+BB975W
	 4eGQ1C+V9OdcIPTMpQEjaYbNayaRYTFkrT/RcrvxhNqLxCP9NPfV8oPmrwsyKIv8G1
	 wEYIR51R32TU63WMET99N5mFER1pxS/Y+txV8MRrxJqhrbZMMOARdEcaMCq3GnveUF
	 l5zgdXJamOv9fgbXntmsAv62DTP7nGo49zXJDC7lXYlch64Htlt1hNRWdM7w6HdkJU
	 ZdowzRdACpGl1Fd0rmgBZ2tH9jK/oWehAYlg9iUuHnz9apbK3o+mYYjwFaZsBD0iCr
	 iqhqdJqyjrhDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A153806644;
	Mon, 16 Sep 2024 14:57:09 +0000 (UTC)
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
 <172649862855.3718215.6305240317449457621.git-patchwork-housekeeping@kernel.org>
Date: Mon, 16 Sep 2024 14:57:08 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] spi: add driver for Intel discrete graphics (2024-09-16T13:49:16)
  Superseding: [v5] spi: add driver for Intel discrete graphics (2024-07-29T08:43:14):
    [v5,01/12] spi: add driver for intel graphics on-die spi device
    [v5,02/12] spi: intel-dg: implement region enumeration
    [v5,03/12] spi: intel-dg: implement spi access functions
    [v5,04/12] spi: intel-dg: spi register with mtd
    [v5,05/12] spi: intel-dg: implement mtd access handlers
    [v5,06/12] spi: intel-dg: align 64bit read and write
    [v5,07/12] spi: intel-dg: wake card on operations
    [v5,08/12] drm/i915/spi: add spi device for discrete graphics
    [v5,09/12] drm/i915/spi: add intel_spi_region map
    [v5,10/12] drm/i915/spi: add support for access mode
    [v5,11/12] drm/xe/spi: add on-die spi device
    [v5,12/12] drm/xe/spi: add support for access mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


