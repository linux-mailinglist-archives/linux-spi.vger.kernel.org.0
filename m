Return-Path: <linux-spi+bounces-1430-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E76985AF3F
	for <lists+linux-spi@lfdr.de>; Mon, 19 Feb 2024 23:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C261C2117B
	for <lists+linux-spi@lfdr.de>; Mon, 19 Feb 2024 22:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096E2535D1;
	Mon, 19 Feb 2024 22:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/lS2b03"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DDB524DD
	for <linux-spi@vger.kernel.org>; Mon, 19 Feb 2024 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708383381; cv=none; b=QlQq7Ysgsk6MVTNUD+japVy5iI6OtdVYuGaS63/Uvz6N1JLfUQnfKbha9iV5htwSM9lpZjq4YltM3ftpQb8XWrFq05aq7cXPCdwGDW2c6NtNAGGV7hvZjQQcqVnK4kaWkhxZ8nrp7tsBe0ihUpfQIzPFdS2DXi3lq+6ikLq8GK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708383381; c=relaxed/simple;
	bh=G+zBrugYE3+EVma6Z8N9Z9zid4O5fc7cnYFr9L+UcF8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=i0TSziV8Q5zyn8GXOx5lpK8L2uy36kvqT5MrGGHAvzOHeN9Q1y8hw07N7JWGQcAAGROZu8Tl+YELf40dTp+O7Nq66hQEOuShDaIFfUrslkJEMRncNPjliNV+NZjTMqud6C+1kXSmIdxtvfsFdQmGWmxms9P7UuUa2Fo13u/sMSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/lS2b03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60C40C433C7;
	Mon, 19 Feb 2024 22:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708383381;
	bh=G+zBrugYE3+EVma6Z8N9Z9zid4O5fc7cnYFr9L+UcF8=;
	h=Subject:From:Date:To:From;
	b=o/lS2b03zzgaHufhA9mWjtZR97b2kS81dc8PLRaz0S3ScbM/Ghea2ykO478hrSoIS
	 MCKEl6I7zrivu+E2ycGnLSbzlAqMxxMUttv0mTFjolQHecm+PtaMmQG7aZek7h9EUt
	 sfoWnO0SFVurLercgU5AfPQHbr7UR4EICFzX1V2XI4Ln8Xn7Vk1Ny4LuC8TYWLMGXB
	 2Gj/gB9r5U7IeYtvKZ8Xu/9Tt2QoIC8s99VTFzOuK+QKMhYhCawpNB7sVgNY313eHW
	 LTG/pSYfen2RLrP6Ii+HxzMYwNPm+pjvikWY0iAFYjqE6kHYlbYio9izLbrk7VKAOy
	 IXHsyhHXO+zdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44E23D990CD;
	Mon, 19 Feb 2024 22:56:21 +0000 (UTC)
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
 <170838338127.28940.13382914292948624277.git-patchwork-housekeeping@kernel.org>
Date: Mon, 19 Feb 2024 22:56:21 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: add support for pre-cooking messages (2024-02-19T22:33:17)
  Superseding: [v1] spi: add support for pre-cooking messages (2024-02-12T23:26:40):
    [1/5] spi: add spi_optimize_message() APIs
    [2/5] spi: move splitting transfers to spi_optimize_message()
    [3/5] spi: stm32: move splitting transfers to optimize_message
    [4/5] spi: axi-spi-engine: move message compile to optimize_message
    [5/5] iio: adc: ad7380: use spi_optimize_message()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


