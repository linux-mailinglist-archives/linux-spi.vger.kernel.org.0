Return-Path: <linux-spi+bounces-9925-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F21BB46403
	for <lists+linux-spi@lfdr.de>; Fri,  5 Sep 2025 21:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522E31C8642D
	for <lists+linux-spi@lfdr.de>; Fri,  5 Sep 2025 19:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD41280CC8;
	Fri,  5 Sep 2025 19:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dC1ThwLR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BF8248176
	for <linux-spi@vger.kernel.org>; Fri,  5 Sep 2025 19:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102218; cv=none; b=pz/AHZRNdkmcmeAcWDglBY4czuMd/vYw33icZUb4b7ORY8wa8Mw5M+xJgLxCHwfxi4otG1J8zBW4jnGtuT8zXyXfFiyDGFd+A213LSRILsEC0lX8LVi06OD5iGdqQUquykfWGYnEY2MAJSVBkHX6+e1iEDKlgv9DpUlaAjgrGlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102218; c=relaxed/simple;
	bh=N50U+gXbSKlF5XlJ327WF/RPQm2nYwZSfVeTzEMMHVM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Hlwww3h34urMtGw8MC+IpOAIf6zxlBXCi3TRgbNgVJxVsAV2myg5JsswahPfMecwn/11g3M1VN6L9dn4GeEo4dOlayTF9TWWaR8r+3AMAv2MzIFXad9tsRRuN11lpfHMqRKBCFeqYsNCNpHw3q/2XzmDjKtfwxso25NNLnPBHZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dC1ThwLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB002C4CEF1;
	Fri,  5 Sep 2025 19:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757102217;
	bh=N50U+gXbSKlF5XlJ327WF/RPQm2nYwZSfVeTzEMMHVM=;
	h=Subject:From:Date:To:From;
	b=dC1ThwLRWw5n30lDDKNP6OEtA4KfGZ+WEoEU3I1UH+TQ6fT9El6uH3uC+PVReGMtR
	 yy5+B5HmZxTH6HswT1seFSweSAKp2GskUrTNLclaA1vf75W/r7/sBRLKG91w89kkSx
	 PFc4B5UwzTo718Vwgm8FE8HKyPvTMKJpoZ9n1PNgiImR82ZxrCQrx6W+xg0qDW9LbU
	 BuIFlNO+aV74FW61auKz7vb+nYcr5cmH3DthZ3V+4k8MVr+/ewefT/vq7YWNxXtCzV
	 WZbM2ADrXpkJigNybu9avovqlhoft0gERrHcZBWlZouPR/DqVz8B8AF9o6yMg9m8QQ
	 6DsiQb/txrv4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DB1383BF69;
	Fri,  5 Sep 2025 19:57:03 +0000 (UTC)
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
 <175710222201.2669882.5895053086724691665.git-patchwork-housekeeping@kernel.org>
Date: Fri, 05 Sep 2025 19:57:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Miscellaneous fixes and clean-ups (2025-09-05T18:59:54)
  Superseding: [v1] Miscellaneous fixes and clean-ups (2025-09-04T13:31:26):
    [1/4] spi: cadence-quadspi: Flush posted register writes before INDAC access
    [2/4] spi: cadence-quadspi: Flush posted register writes before DAC access
    [3/4] spi: cadence-quadspi: Fix cqspi_setup_flash()
    [4/4] spi: cadence-quadspi: Use BIT() macros where possible


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


