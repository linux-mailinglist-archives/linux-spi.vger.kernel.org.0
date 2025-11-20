Return-Path: <linux-spi+bounces-11375-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCE0C72FDF
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 09:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED77D4E3459
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 08:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7352C30F93D;
	Thu, 20 Nov 2025 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVIsDq8N"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFC030F7EB
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763629077; cv=none; b=ORRl0TVJtjSRhPxzUhxaQg5irYIPxxw+fP68t1PQl/apkq6xMu7GXW5wpztPE8dqKOuKMB8SUbNqWoivl60ZZViYxte4iYwdZIHO0P8pJbEs5oXAj3F5dxLFH3pYgZBBOXtg4JZVXrfQsRBFj8ktFBZ5jrnytnk6IzD7ETQdETA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763629077; c=relaxed/simple;
	bh=22Jjec2dx6e8mspUbKqfEhV24fhkJQo/LdK/OH56grA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=iEbhU5K/nyB2kISFfCxOimEGhBE7MMiiF6TmOO5kFnmO3hL3QvGw3UmSKeL5/0DDg2QqpdDJpzVrZnU4Q26Hlkwho/+8LgtxadnrhhY1F0nRiwphig5zt3PjnI8+dv96DWoNguwhQQro1kuXC92u9Twx6YjY5tV3HtDU6SrGYzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVIsDq8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFF0C4CEF1;
	Thu, 20 Nov 2025 08:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763629077;
	bh=22Jjec2dx6e8mspUbKqfEhV24fhkJQo/LdK/OH56grA=;
	h=Subject:From:Date:To:From;
	b=mVIsDq8NPtfQukRFW8xAH12hio4IYGXs9UTyQcsAyOcMDF1cM0TiQ9eo6QMYmCS2o
	 ODhn16rGwDURZmLImfhwOOJNw15Wfmt2ASg20njJuW02HsjN5URCPaeg9QpEqVTx+W
	 qmfNkgbbdhx0L04yhQ2N7Fm2UGWxwJzTwYK5eaYW4PVEmM6lZNYKo4UcmvYVBSViiM
	 gKxpMiLnDZZY+hIa4qtB5yXZNCxFzgDcqvqp0oJl7mZjn3g/wkFrOvKeELgsVftdGn
	 mXPvBfGpPgKj8xNW4EDgBqDaWMYyaZMxZwFY7f1DvBgqCKeYm3tpoLFScoyzaVxuEx
	 Jv+uknG0MlwSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BC74239EFA5B;
	Thu, 20 Nov 2025 08:57:23 +0000 (UTC)
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
 <176362904255.1531185.14146976364314859482.git-patchwork-housekeeping@kernel.org>
Date: Thu, 20 Nov 2025 08:57:22 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: fsl-cpm: Check length parity before switching to 16 bit mode (2025-11-20T08:34:49)
  Superseding: [v1] spi: fsl-cpm: Check length parity before switching to 16 bit mode (2025-11-09T18:55:50):
    spi: fsl-cpm: Check length parity before switching to 16 bit mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


