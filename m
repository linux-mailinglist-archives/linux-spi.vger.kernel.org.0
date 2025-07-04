Return-Path: <linux-spi+bounces-9057-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD9BAF9966
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 18:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDB27485C35
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 16:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22131DBB0C;
	Fri,  4 Jul 2025 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heTU9Wbs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C09F2E36E4
	for <linux-spi@vger.kernel.org>; Fri,  4 Jul 2025 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751648304; cv=none; b=IoFh5qPpvOGScHV1/qf4EOp1Twq9hiFDkrN1QC8bPmphFOaZcfg3FcX6xHhC4fw0BQB920PXMq71Cci2nGp+jFEeiXNJg+l/Th3LxgTejDObZRsXjy0hBoDEt4n3FB7odHBwBK13IaNiC2F+2x6CbiMIy4WbBNMdaXyfnVQrdFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751648304; c=relaxed/simple;
	bh=VkF/Y0a2YnBq1RaZmYp5WTxcJAZitxUaP/DP/2qQQDw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=SkIDtJvZ6KvgPj5I19tVdKqOcMdeS7+nyCPicWxlEq3rGuWMZZrrumLycMpg/RISN7CNuuuMUZqquMtzX4BLE0qc2GOGpnRociYeaOGv+ri/7zpzePVUgq4wh0SL2Qn5T8McTx52suMQcSn1ZdcZLY2PovB5xXZ3hHEgGea4MAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heTU9Wbs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A22C4CEE3;
	Fri,  4 Jul 2025 16:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751648304;
	bh=VkF/Y0a2YnBq1RaZmYp5WTxcJAZitxUaP/DP/2qQQDw=;
	h=Subject:From:Date:To:From;
	b=heTU9WbsrzxRi8nBwIVPhZiibxtszTGv1cjsEgsSl27pMcZ90j8uymb1VPDJo2fWn
	 Jggoc18JTitHkN13soRAkBwvtC4oHr+qVBgwaBqCObGNeOqiZ8heAr4RD3Jzvpb+s5
	 e/w/Eyrk65FX3UBVGXlNFGxT/slC/9gWZDHkAuks0OfNlJo+4CfVY1Kn1joi6norn+
	 /TYty0fQwIqsXo45YTfpKCwu/KuLPssonhlK+oq9ggMfnyYZQWXz5jAslHYnyyr0lC
	 9lAlDdBiqK0vW6DjwYb958QaADGrfwjTDRzCLnqGcUD8iMKd6PlKoIZsDb+Y+15HHD
	 qdNuB7cPvBuBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D6B383BA01;
	Fri,  4 Jul 2025 16:58:49 +0000 (UTC)
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
 <175164832794.2276892.2030777524700064236.git-patchwork-housekeeping@kernel.org>
Date: Fri, 04 Jul 2025 16:58:47 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Add RSPI support for RZ/V2H (2025-07-04T16:20:33)
  Superseding: [v1] Add RSPI support for RZ/V2H (2025-06-24T19:22:58):
    [2/6] spi: dt-bindings: Document the RZ/V2H(P) RSPI
    [3/6] spi: Add driver for the RZ/V2H(P) RSPI IP


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


