Return-Path: <linux-spi+bounces-3355-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B3C9009B6
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 17:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86381B236A7
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 15:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6021991D5;
	Fri,  7 Jun 2024 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dcfi5UNy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAC81990D0
	for <linux-spi@vger.kernel.org>; Fri,  7 Jun 2024 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717775805; cv=none; b=jpyWWT/aM3IWOLEp7YHY/tDaMDlGte5ARCoG1dFBbcZifN6sd94ntMpK56yuK/YQUff6xd1rf+3DRnLwBCE/oQSW8xFHnn3EW2I30Dzds3Ex/3Ee2pAnq/cSA4Ur/rJTF7Lac8GQb3cc6/bBpG/ux/71kC0SJR36Bk1WroqhZ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717775805; c=relaxed/simple;
	bh=aTgtxBXUR+dZxZ25+65AkyBm8wJqxluHCS13hzmT6WM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=BOIcg2UclzWvXYjtjcgE05qjSpVGKo61rgqQlTJMDmz8YjMdIA06sCEsGq5kR6g/OnKlkxmojQfwVf2+VF/s5eOuAHcmdwG3tEb+Af0DiBiXDQZChyssapU481gyVuIHFcMcMzgfaP0C5oGJ102bKUiyUVZQjy1Xz5MfT/go4zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dcfi5UNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CAE1C2BBFC;
	Fri,  7 Jun 2024 15:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717775804;
	bh=aTgtxBXUR+dZxZ25+65AkyBm8wJqxluHCS13hzmT6WM=;
	h=Subject:From:Date:To:From;
	b=Dcfi5UNyAbwMJqXl5LrFJtBvnBeQfTt7oHT2rlEwdo7FpEOB9c6m1eP/d+rmqSR8T
	 3z5Exb74jybKNi+I6LZ+87cBX8IL1adE/VMW043AUGhlT3mrvztQXJbv0uwhT8VHPB
	 hE9DjUq5fKJn0TECYRLz6GmFqDFDInha1KMyiBI5Pl5AibTgXRKb1E3uWH9tlRsXgJ
	 hGGrxq8kWR9EDc9d+OkvXf1BEJnOnZcW8wfLy08yXCjwhrcEAB5PeHTFFqEo/UnZNK
	 VnpwsNhFsObmXA3IZttTvZfAjactbyJoCfo99hDfDpHKKsTwguppfjU98Y+QcXLUw7
	 1FoO0En/DdANA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B197CF3BA3;
	Fri,  7 Jun 2024 15:56:44 +0000 (UTC)
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
 <171777580436.26672.17175407225413667423.git-patchwork-housekeeping@kernel.org>
Date: Fri, 07 Jun 2024 15:56:44 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v8] Marvell HW overlay support for Cadence xSPI (2024-06-07T15:18:28)
  Superseding: [v7] Marvell HW overlay support for Cadence xSPI (2024-05-29T22:00:22):
    [v7,1/4] spi: dt-bindings: cadence: Add Marvell overlay bindings documentation for Cadence XSPI
    [v7,2/4] spi: cadence: Add Marvell xSPI IP overlay changes
    [v7,3/4] spi: cadence: Allow to read basic xSPI configuration from ACPI
    [v7,4/4] spi: cadence: Add MRVL overlay xfer operation support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


