Return-Path: <linux-spi+bounces-11391-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8C2C73D7C
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 12:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3A014E30EA
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 11:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9E432FA0E;
	Thu, 20 Nov 2025 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THMg7Oki"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDE8330B0D
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763639865; cv=none; b=AD0CuMqV4dBAXDGW35xM+JLuZTudCFVyrscF7gVGfDv1OSDrdyJUFOIiTydpifjyqnb8Gqegpq/tsvL8UdHKmd83Ip2db8KkQPPCaaUabJqQxy0EuUBMel1ofpTxcEDPmvr5YIbDJbFPR3XdMzr0Yjmd5Gzy56BjDUSV51S3qi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763639865; c=relaxed/simple;
	bh=Pm74W3svdgfENPNmUZt4bvWwVJuBenu09Cc3BUoT780=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=axHq9UPRNdrX4Ei+5wu+peaMxj4DtzNP1OwcArqKE/rrve89KeBcxLZvLaGFiDrWtcUX679gd43uAXeX/t+5e72v75UiTB+x+RFo3G7HTnqZ36S8RMMbIzGG5sVtyYxtgQ9LjLi1vH3iWKhiiqvuCC4O9D5tkr5cvg97sLEguSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THMg7Oki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0532DC4CEF1;
	Thu, 20 Nov 2025 11:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763639865;
	bh=Pm74W3svdgfENPNmUZt4bvWwVJuBenu09Cc3BUoT780=;
	h=Subject:From:Date:To:From;
	b=THMg7Oki7QF7GYfVQImmIxQ65+RDpeqgjsqRviCKmrGXmA7mdZZ+8QUkWEkKBao8h
	 z8At4FSOap3u97xu3nxxt8x6tMkkLtd7xTpq8YmMMb0njSsEAVKGfRAwJyHZqV2duj
	 mGcfAoupccmNRoCWM7d7GbQouEAW1EnFEOvexXLJERgqTXpDQkybONxG+CgWnVZLEl
	 94zihn+eToi6XHdppbTLkxLm7dXAmfPZ+qoyayg5g4fxm991yFUSbZUdHe1Tn7jeZ+
	 LFRRtaI4tCK2FC57R+Fh26Qli5nW9LzD/T97F5eAikjzMVkHkVfH9NFCI9Kl1Jjv78
	 jBdRKAVmGs6YA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DA339EFBBF;
	Thu, 20 Nov 2025 11:57:11 +0000 (UTC)
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
 <176363982993.1591899.11854612808271100728.git-patchwork-housekeeping@kernel.org>
Date: Thu, 20 Nov 2025 11:57:09 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: cs42l43: Use actual ACPI firmware node for chip selects (2025-11-20T10:59:07)
  Superseding: [v1] spi: cs42l43: Use actual ACPI firmware node for chip selects (2025-11-19T16:40:17):
    spi: cs42l43: Use actual ACPI firmware node for chip selects


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


