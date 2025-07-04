Return-Path: <linux-spi+bounces-9038-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 684DBAF8621
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 05:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12092486808
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 03:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97E01EEE6;
	Fri,  4 Jul 2025 03:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qk/YKFZ/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2C91E32C6
	for <linux-spi@vger.kernel.org>; Fri,  4 Jul 2025 03:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751601478; cv=none; b=JV/7ajk8r6JuKy6Z627KnfCsbyAtBLM3Y5HjCHTlMuvBsd2dFHCpdzQYyadbuPyDIPzazkQGRu68DBWe7QiTLj1mVFhQL8m9Uldwmd/0IizaT/vQZGjd5laJ/XSwTCF4CLzHpBSaxo//JI4OIsbmJhMDv68HY7QN6TIuif0qG9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751601478; c=relaxed/simple;
	bh=Ye2Y+9hmvaZhwuxigw3KFFFabJu3xHqPPFxsijpbKJM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fgCP+yOer2YoPG/UpeURsDRCwcw/ZIQJDizVHopwUzg5FvvKTf1mYimTYyr+MwJHX5HHbap7tbr7Fellm6F2o8AwXNpb8bv6jlk8LEZlzuhnJAV539tU1kShvAeoa/pj729fgUtMDJO/sRPgfk0jov7MpDZnBiaDWDVuT3+40xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qk/YKFZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354E6C4CEE3;
	Fri,  4 Jul 2025 03:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751601478;
	bh=Ye2Y+9hmvaZhwuxigw3KFFFabJu3xHqPPFxsijpbKJM=;
	h=Subject:From:Date:To:From;
	b=Qk/YKFZ/E5DDOfYTPeTWmC6hS7hnW3tk3z1heuyj1DVH1d5t50uBqDEaQYHR5Wp99
	 03aTAc0PLrqS+8A/2DBMrr8S70E/mYMSK151ka/Yo4nL7XGVL25xTBmrW9kWG7eA+c
	 EAEH7bxb8STMs7aPJlbB0GS52LABljOIJcwhX6gQBOV6z5Wta08qMEGQLUnZUCQBov
	 Pq5yoeVfBh0bmjMmbVmkDFrPboyUyl4NEV78wKPZobmSbUMKff3ZDtelaXaiFU4hB/
	 nnPsC3liyswEZLfSTTbksip5ifpJkvqtuJJpFZ4ay7p5ivvrLidk+TZJ5Lbo0L4TbG
	 eACTPeKOC0kOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74069383BA01;
	Fri,  4 Jul 2025 03:58:23 +0000 (UTC)
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
 <175160150207.1696609.11037566259391324647.git-patchwork-housekeeping@kernel.org>
Date: Fri, 04 Jul 2025 03:58:22 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] support for amlogic the new SPI IP (2025-07-04T02:59:31)
  Superseding: [v3] support for amlogic the new SPI IP (2025-06-23T08:53:26):
    [v3,1/3] dt-bindings: spi: Add binding document of Amlogic SPISG controller
    [v3,2/3] spi: Add Amlogic SPISG driver
    [v3,3/3] MAINTAINERS: Add an entry for Amlogic spi driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


