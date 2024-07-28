Return-Path: <linux-spi+bounces-4037-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8E393E593
	for <lists+linux-spi@lfdr.de>; Sun, 28 Jul 2024 15:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86C3BB21582
	for <lists+linux-spi@lfdr.de>; Sun, 28 Jul 2024 13:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C701EB44;
	Sun, 28 Jul 2024 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1jscU1C"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A438A35
	for <linux-spi@vger.kernel.org>; Sun, 28 Jul 2024 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722174992; cv=none; b=WkvMXer2P9LwQPtRRY163qG/mE6SoqRQIwfMeztN3msw1tr1Oz0BEynInNuHZNMp0PfSj+VrFdOfWBYwjVVcJQKkGnAm34J8RRoP5hBBQy+bBgcbqkVgOHHPHcFHeIKZXB1nbY55vyGRrLe1LE0LEcUPKYHAhi07xo21hqIXcWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722174992; c=relaxed/simple;
	bh=NfVMitPaWD+19vot/pP2qK8eDZnZVG53+YzpARn4VEs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=a3+ND2yFoyHZ8KrCYEG/j0o7TG0zFVRYgRr49CzKdrfTLVhmvUakfs/AkAc3hbMr8u4YKUHsFFLYan8yb8u3H5RpYzHpVtiVnghthnHGHTGnVmTlOIuMGFzCcB/zN4PTyx4mQqccQMZpl9oJbOvnRes4528S9UoRBsDF//aOYok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1jscU1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3F5CC116B1;
	Sun, 28 Jul 2024 13:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722174991;
	bh=NfVMitPaWD+19vot/pP2qK8eDZnZVG53+YzpARn4VEs=;
	h=Subject:From:Date:To:From;
	b=k1jscU1Cf4H49/t1LcuRSLG6NT+2JSjt20DPISOJfQKgaEqzgn7jsmh+GroVz8BE9
	 zM/4TyxIe1yXvXM8c5VzVCQPyhrdnnZARWdB0GbmOPFC9OGMuePJBexumpJm5IU953
	 l/rlagk17eTw5yNWzNlWzL6kx1n+j2+nt4uBbju8BZfzRl++ZJGSG2Zn5VPR7oFT5/
	 Nog8zLot0yxGC1JqVBgvIUfu/pWQVdZjR7E9UfJau5R2fzXfqZd0KD/T9h+L6atMiS
	 29w+2PzB+x7Pdpkalwkwlgte5z6EWdAct1YJ9qOFZOc9eWYw6cJZVj80kVEoRhTb6G
	 jy/0OxWvOD+4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F621C4332C;
	Sun, 28 Jul 2024 13:56:31 +0000 (UTC)
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
 <172217499158.6930.18157292647016941145.git-patchwork-housekeeping@kernel.org>
Date: Sun, 28 Jul 2024 13:56:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: add driver for Intel discrete graphics (2024-07-28T13:06:26)
  Superseding: [v3] spi: add driver for Intel discrete graphics (2024-07-25T13:56:45):
    [v3,01/12] spi: add driver for intel graphics on-die spi device
    [v3,02/12] spi: intel-dg: implement region enumeration
    [v3,03/12] spi: intel-dg: implement spi access functions
    [v3,04/12] spi: intel-dg: spi register with mtd
    [v3,05/12] spi: intel-dg: implement mtd access handlers
    [v3,06/12] spi: intel-dg: align 64bit read and write
    [v3,07/12] spi: intel-dg: wake card on operations
    [v3,08/12] drm/i915/spi: add spi device for discrete graphics
    [v3,09/12] drm/i915/spi: add intel_spi_region map
    [v3,10/12] drm/i915/spi: add support for access mode
    [v3,11/12] drm/xe/spi: add on-die spi device
    [v3,12/12] drm/xe/spi: add support for access mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


