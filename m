Return-Path: <linux-spi+bounces-9665-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC3EB351F3
	for <lists+linux-spi@lfdr.de>; Tue, 26 Aug 2025 04:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC573A5251
	for <lists+linux-spi@lfdr.de>; Tue, 26 Aug 2025 02:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7805D29D272;
	Tue, 26 Aug 2025 02:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbvuLiht"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5108726AABE
	for <linux-spi@vger.kernel.org>; Tue, 26 Aug 2025 02:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756177003; cv=none; b=mvJBwwRRmVWlSL6AxP+OPSWoBLRtdRY5Usb7DVh70t9oRwT5qvOtNx7+CTzIfQNqBELtVpnS6DvFbbRE/NWetWmpYq47D4J6/Eu5o0sJoILsgySJbwzsRSEmFpb9EH5vb//qPN3fFWWE9NHnZREcTDbalNC90xURoykRmHXF2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756177003; c=relaxed/simple;
	bh=b32PakdJ+7dD/petLTBpDxsV+MBOXQLXZVeYTJDJqMA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=nmcfmNxtIw1RKP/meZL+awUC7p7Bq1eWCbPMR2f+fIoBtuoqe1ZqoiMB+pZfCeudG9HQHjAfv7Xl0OzrLPr1EWpe3xj8l1cn2Mn+Ko182XJ+Z5EDS9AKvIHKzSL//t9xDE61IsUz6hxEoSI0ibG8iWdYi8Fi491KE4BK0tbZz9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbvuLiht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE31EC4CEED;
	Tue, 26 Aug 2025 02:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756177002;
	bh=b32PakdJ+7dD/petLTBpDxsV+MBOXQLXZVeYTJDJqMA=;
	h=Subject:From:Date:To:From;
	b=YbvuLiht3KmvqPpax+KrwGSX7MuBUzj37uDUEVUYLGezkTLPbsJ/3KPFrr9SlSvj0
	 Gnh7JFuTlkhFXbnCLwh0h4o7IPjpHPqrxe1RIVlRqYs1lYjTlvj/ZfVSJ7SwZIZfGD
	 ZtzcQbfisZ5SQL6+mnSL+akoBDO+gCxla+ZLB+GyCqsvw5g1NRKcDIwy1huhv9fVKV
	 o4/T2k0NYXl4l+DIkds0gMO965n+mUmaSDeIXDk6eO+OzOSpRVjpsUhEwGslzD4mO+
	 STI1J1DIYuj9y5G4dcrbIsmSaYgJCYXMkyy6CUp6tY7400GZdRRMgnPaxaGGqS9+Y7
	 vgGcCrJraLlSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFBB383BF70;
	Tue, 26 Aug 2025 02:56:51 +0000 (UTC)
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
 <175617701015.3636218.4962313474752324348.git-patchwork-housekeeping@kernel.org>
Date: Tue, 26 Aug 2025 02:56:50 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] support for Amlogic SPI Flash Controller IP (2025-08-26T02:10:11)
  Superseding: [v2] support for Amlogic SPI Flash Controller IP (2025-08-21T05:17:15):
    [v2,1/3] spi: dt-bindings: add doc for Amlogic A113L2 SFC
    [v2,2/3] spi: amlogic: add driver for Amlogic SPI Flash Controller
    [v2,3/3] MAINTAINERS: Add an entry for Amlogic spifc driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


