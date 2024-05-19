Return-Path: <linux-spi+bounces-2951-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E03FB8C96E2
	for <lists+linux-spi@lfdr.de>; Sun, 19 May 2024 23:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8014F1F211DD
	for <lists+linux-spi@lfdr.de>; Sun, 19 May 2024 21:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8F04E1CE;
	Sun, 19 May 2024 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwN05chY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD1C23BB
	for <linux-spi@vger.kernel.org>; Sun, 19 May 2024 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716155793; cv=none; b=Ti6ixVuyI6efCwIUlgh8G8ShoUsJRV6XxzJutb62Er1mF98o0Et7BgP/6odVqs6gNhaIIS6ki9Pcjwb1Egd4jo/Ozeth3LnBAu4VyZ5MtoeieQWCWvHOnzKZEZptmcsG4nhG66S9l02YI33WsFaD2+mOzSgYlb9xjZNwehXKroE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716155793; c=relaxed/simple;
	bh=w1iQ0M0BgyTL9ZfraZNJoFogJ1HvsDqBav3wDmdGHTI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fPK6MU5Mw7qwuVWYJWMHQ+P7zUew/LXKc54LoMnRsX77LpVmJNm1eBszG1nAlkjxag5FE9acpoaLNZSdkLPdQy+oofrGCFLnrL8SJbrA89jQ5MjAuoq1W/nceg6duN9imTdBcWo+I26QyxoIaLOJLKVC9IZO0pvuKph/XuU6LlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwN05chY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15200C32781;
	Sun, 19 May 2024 21:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716155793;
	bh=w1iQ0M0BgyTL9ZfraZNJoFogJ1HvsDqBav3wDmdGHTI=;
	h=Subject:From:Date:To:From;
	b=qwN05chYFkOSOvVeauczSTH5tuS1uxu6xTkGFHZ9qnC8fpL0cMmXqionmtPitExXs
	 ZFPe/86j8STVTNAglUCgAYQl44+cuKtDdwR16tZSTikCMRNlukDfnTkCBForpmklyZ
	 Xcpn2whWJ/zgmB93b3wkAxeUodBWbiTxD0KQYWSZp13XoOEjr4dg4AJUTMxj6YxpeN
	 AVjOEyNtrD63fEdC7m0GSWZkqY0MPeuSovM1vRUdT8sLhxgl5jw6h+HKsrmPVGodxW
	 OclbxSnCcaTHJ9kSZEsCe6konsbm4XTuHWmmGAkB7tOriZcEi6xmdeYQpqJW9iEp/d
	 PJc40qhfLFIFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EECF6C41620;
	Sun, 19 May 2024 21:56:32 +0000 (UTC)
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
 <171615579291.15221.8266805227449047871.git-patchwork-housekeeping@kernel.org>
Date: Sun, 19 May 2024 21:56:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spidev: Introduce "linux,spidev-name" property for device tree of spidev. (2024-05-19T21:13:46)
  Superseding: [v1] spidev: Introduce "linux,spidev-name" property for device tree of spidev. (2024-05-19T18:10:39):
    spidev: Introduce "linux,spidev-name" property for device tree of spidev.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


