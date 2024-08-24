Return-Path: <linux-spi+bounces-4304-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5908595DD43
	for <lists+linux-spi@lfdr.de>; Sat, 24 Aug 2024 11:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3CA1F20FCB
	for <lists+linux-spi@lfdr.de>; Sat, 24 Aug 2024 09:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0C414F10F;
	Sat, 24 Aug 2024 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Az5pgDSs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7683E2F29
	for <linux-spi@vger.kernel.org>; Sat, 24 Aug 2024 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724493403; cv=none; b=FHw7xfNMS4Tq5W9wcjSOM4HedZ9vnq97DjumdnBV3o4fSQPDp0kYtjku+kq3XVB+OalIDmAxxN++yTtWK1pjo3NJdgEOU7aztYlVTL2ECb5ethyTcPsllUkJ9Wc1WfHdxDEX+J9mjfOrn4r/D+3bvR+2d3IEAMkJdC9fxgWpVtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724493403; c=relaxed/simple;
	bh=9DADEiYoqlSzwh9llO59trFA0o4e5fB0+9ucseabqKk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=gJKtk/m9HefGm2trD6e2XHNd4njpr+Hs3EpcVpcByV83M2AUISuTsbCw+GL0YjVPlMQM6SeFUqWD0eO2Aom7mQdv5ouX8yYsXTK9z7RpjszvSgiUWQs155TQ1nS5sT+JbArtttwmA3Z25Xo+HzLGaqxJu/VurmSMqr3a0v1G2EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Az5pgDSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC78C32781;
	Sat, 24 Aug 2024 09:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724493403;
	bh=9DADEiYoqlSzwh9llO59trFA0o4e5fB0+9ucseabqKk=;
	h=Subject:From:Date:To:From;
	b=Az5pgDSs4+WrHvDPoqKEm3Kt+MTPN/cOPK/Hu//pAf9qEMy+Pf72bCPISaPxArPLp
	 4iIpT4fBXdynSBBM1Xkh3YiKWdSHwYA8tGDzrURMDxphkJ0f/PGk53xBx1RclzT3Qq
	 tMJTlsnz8o32EKaKDE3RUbjgpeYQErovL9yCopJjSmAwKQztq0Z/h+hwqzkhVKE1GY
	 ubrxO11D0Z3nlDCrvz2kWO9fomk9BMzpKeu6a1TYyXJvQZLQhIcrkvwQWJXD2tmahp
	 ywzVdpjz0opBhV8ujdgx5joma31/LDyjSBzk8klv4YLxxZR7MiA/wKl2YofUPTUxIq
	 csXYYCINAxsRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB72D3823327;
	Sat, 24 Aug 2024 09:56:43 +0000 (UTC)
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
 <172449340251.3203264.3919753264037042954.git-patchwork-housekeeping@kernel.org>
Date: Sat, 24 Aug 2024 09:56:42 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: rockchip: Avoid redundant clock disable in pm operation (2024-08-24T05:14:52)
  Superseding: [v1] spi: rockchip: Avoid redundant clock disable in pm operation (2024-08-24T04:57:02):
    spi: rockchip: Avoid redundant clock disable in pm operation


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


