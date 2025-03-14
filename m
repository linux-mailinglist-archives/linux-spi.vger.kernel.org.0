Return-Path: <linux-spi+bounces-7150-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06415A61591
	for <lists+linux-spi@lfdr.de>; Fri, 14 Mar 2025 17:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F2B19C0732
	for <lists+linux-spi@lfdr.de>; Fri, 14 Mar 2025 16:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5144202994;
	Fri, 14 Mar 2025 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbvQGmPV"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9099D20298B
	for <linux-spi@vger.kernel.org>; Fri, 14 Mar 2025 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968000; cv=none; b=BVxSRqmX14ANMs/ALFnuoaWD9D1E9QabhumLDH1+uVMqR23b7stHui0Pv6kTlA273eut33qgF+FGbrdhTixdTWpk9okwc0dcfiFISMnkA71UbjvkX1qBMOLvelOgqsFuc3+Jsw2zY/U5byqFG6gmKVeQbxPmq5+4i0Eqg09BnV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968000; c=relaxed/simple;
	bh=hmUW4Gqt7iCNz0TIG8u5WPbPPF1ltj9/Do+NQV2014E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Wj2PDTh6YP0swnT0GhXinTnAgNcQ90OX2zCXUiwZcl5+IQ6lr4sHEX0gMNhbT6mOqElfwdc0BDyjEsGZx4IUeyIdCnMAnbbaOvtOOiMGFWebByE88CjvJRlAaljgB+lsQNqZANn3+v7vlgKYxSNVvai4dYzqktT7VFJOM40Avvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbvQGmPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141A7C4CEE3;
	Fri, 14 Mar 2025 16:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741968000;
	bh=hmUW4Gqt7iCNz0TIG8u5WPbPPF1ltj9/Do+NQV2014E=;
	h=Subject:From:Date:To:From;
	b=pbvQGmPVa+9zk02mZ5PEalIzthKDe/al0lX1niy09S3ZvCocAn1BnGNf0/ZDWD4Ws
	 zqPLIUG4FeYH8nWP/MWASov/zCyfI3x2T4i0JzKAIKj1EqN0C99GdMs1tDjsasz9Tm
	 kvo+vBTCM74Oc3ULD3g1qNVRgvH9M+4vuDHbTWN8Ib5xkrGH4zhwOEpwkGhtKOz+6W
	 e41ynJMkvyzZFPZR9gvzgbqGUaK6W3MdRYKGyfrJ5pbmnXN3N8DZSwjDqpOQ5xfS96
	 0SiwMtvVqrwjjZHvvnrCXCBtdOFpD2tZWqHhsPGERJFktdbNL4EOAwTuSIl/eE0P+b
	 LoyhCore08C5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EE6FA380CEE2;
	Fri, 14 Mar 2025 16:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <174196803439.2297266.3053916145800097530.git-patchwork-summary@kernel.org>
Date: Fri, 14 Mar 2025 16:00:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: arm64: dts: freescale: Add support for the GOcontroll Moduline Display
  Submitter: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=938078
  Lore link: https://lore.kernel.org/r/20250226-initial_display-v2-0-23fafa130817@gocontroll.com
    Patches: [v2,01/12] dt-bindings: arm: fsl: Add GOcontroll Moduline Display
             [v2,02/12] dt-bindings: vendor-prefixes: add GOcontroll
             [v2,03/12] dt-bindings: connector: Add the GOcontroll Moduline module slot bindings
             [v2,06/12] MAINTAINERS: add maintainer for the GOcontroll Moduline module slot
             [v2,12/12] spi: spidev: Add an entry for the gocontroll moduline module slot


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



