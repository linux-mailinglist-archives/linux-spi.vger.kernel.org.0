Return-Path: <linux-spi+bounces-6462-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61404A1B433
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jan 2025 11:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1BE16C444
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jan 2025 10:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B7E21A945;
	Fri, 24 Jan 2025 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrTIXV1k"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B15021A928
	for <linux-spi@vger.kernel.org>; Fri, 24 Jan 2025 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737716183; cv=none; b=kKj4nNMfkGoThCpTTHmRlVBpQlv76D3N4JkxbO2ZpArl3ee2NVACplCABkXgfY87y+jpSLHDRRkXVkg0Sc9OQ4FGLaJOQBjB31r96sj/lO7aHkdSoetyAQKPpk4uwrYoSnmSVjB9gVkQaE2ho6iwfkJueDbPmkIsF+IxPtmoF7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737716183; c=relaxed/simple;
	bh=VlHfdNkDDzhyUdyi622flOTDGAgppZGyqFfD2w89TyE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fjPO9u3xA+asmiArNv3R8/Q7dxdi8dYDIVXjYhyEQPuRf2hLsHdf0jYmlQbos4CWTRI5jtn88ZyY1qtcjIwlGnGYSqGMZJoXip0ds+6StwaV7yNot9hAFBGx78iUuTUXDP+ItyyEL6TiPB8jCvIikuwkoLWjboSfCIzs+BfGq5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrTIXV1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF56BC4CEE7;
	Fri, 24 Jan 2025 10:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737716183;
	bh=VlHfdNkDDzhyUdyi622flOTDGAgppZGyqFfD2w89TyE=;
	h=Subject:From:Date:To:From;
	b=TrTIXV1kJH8jyiq02F5lEiUu7BZEaMT58HS/Gw/ythF3PYuOxcvFISn3NsRvB75oj
	 kyIRhqBwRiB06Nn4knvV/fh0v2rL2wunTBqmxogPykh1NEt2Ct06Ah+vlHrvblxH3M
	 raACqUk/8e+pa3MTO6DSEoD3Et6g70zI85VE+mgvB1ekaFiBQtvxETSBhZMM6PYNxI
	 3gdxIdlorBs9VibpKRnMdaCGt4Cc08mPr9/y3c0841OqJLDZ29tKzeRsVjV37tHXmE
	 YeKooWXsQ642ko21CZ7aavSAFhNLR9SZ9QvOZeJytFgIg1Ih3BFEu6G50F0YHlfqV+
	 fynadDZbeAvbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE05380AA79;
	Fri, 24 Jan 2025 10:56:48 +0000 (UTC)
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
 <173771620748.1994582.1520337194805048582.git-patchwork-housekeeping@kernel.org>
Date: Fri, 24 Jan 2025 10:56:47 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Add support to load QUP SE firmware from (2025-01-24T10:53:02)
  Superseding: [v1] Add support to load QUP SE firmware from (2024-12-04T15:03:19):
    [v1,1/7] dt-bindings: i2c: qcom,i2c-geni: Document DT properties for QUP firmware loading
    [v1,2/7] spi: dt-bindings: Document DT properties for QUP firmware loading
    [v1,3/7] dt-bindings: serial: Document DT properties for QUP firmware loading
    [v1,4/7] soc: qcom: geni-se:: Add support to load QUP SE Firmware via Linux subsystem
    [v1,5/7] i2c: qcom-geni: Load i2c qup Firmware from linux side
    [v1,6/7] spi: geni-qcom: Load spi qup Firmware from linux side
    [v1,7/7] serial: qcom-geni: Load UART qup Firmware from linux side


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


