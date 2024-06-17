Return-Path: <linux-spi+bounces-3412-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C406C90A7DF
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jun 2024 09:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CA028148F
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jun 2024 07:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D57190042;
	Mon, 17 Jun 2024 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtOBY4qr"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F91118FDDA
	for <linux-spi@vger.kernel.org>; Mon, 17 Jun 2024 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718611009; cv=none; b=Oc3MJ/LmA7iMJgm5gtjILuX7g1jAAZZN2/VGLkNkWHhW0sdEvXEZ8Vbo4jWdlojazQxiaRRcrZhGmNgjAO42LxR5/VQkzdgD0yqqKo8ow9H758BUblX4jC0q1iISUVd8H/nM5L6uhAYhHAY0iL2dEeoqziFgbl6G/FsqUHA1XpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718611009; c=relaxed/simple;
	bh=BWFSLjkFDVkAAi1T8hujBE9DPDhQxhOIV04JxQ2zh7I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ntCcYqZLzc7RufnKAtaqFFdik+JpunZVNszNaU07GQzsVZzQhHT1Z+plEnXirkboOflLFrK9IdJtpOn3Nd7wPqsLRGfWn0j8bUJOHQI9D4YSMiAKMCDg0B6qfl0Mtpg7ggCZhWkZi8Tewgg/7CicxphFFz2Yl3iyZ3rVBhRAEZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtOBY4qr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08301C3277B;
	Mon, 17 Jun 2024 07:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718611009;
	bh=BWFSLjkFDVkAAi1T8hujBE9DPDhQxhOIV04JxQ2zh7I=;
	h=Subject:From:Date:To:From;
	b=OtOBY4qryklInu/zheTdehgO5Q/+VY7ISEsWcuRTvhu8yNoY+HzQHn9sCXtww3ruN
	 rI0gypHAJgTJceowzEs4t6O/BVDweylfD0CfW+KY6+LCAG/GMYKxT9c+JVBDee9moj
	 +CqSZiQJyJT8A6B5fYZGaHrv2PYgHr+pCs9+GzoP22E5d90PmCkzbElton6VyRvoE0
	 pMU6ab6gtpPJwc1UEtcuFpDXQUUWdoDqErDhQapUwToVp5GJ3VtOOOshqGnh4Y3T7r
	 mbkutHNU997LxtqEK4cCrumGqDJT7wrLehOyJbSICHZ65w887Uo1Tn8phgOZfEg0HT
	 rXiTW/qlOL96w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9AFDC4361A;
	Mon, 17 Jun 2024 07:56:48 +0000 (UTC)
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
 <171861100894.23363.15787188002211837062.git-patchwork-housekeeping@kernel.org>
Date: Mon, 17 Jun 2024 07:56:48 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] dt-bindings: drop stale Anson Huang from maintainers (2024-06-17T06:58:28)
  Superseding: [v1] dt-bindings: drop stale Anson Huang from maintainers (2024-06-14T09:59:27):
    dt-bindings: drop stale Anson Huang from maintainers


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


