Return-Path: <linux-spi+bounces-1622-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCCD870646
	for <lists+linux-spi@lfdr.de>; Mon,  4 Mar 2024 16:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FCEB1C20F57
	for <lists+linux-spi@lfdr.de>; Mon,  4 Mar 2024 15:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB80347793;
	Mon,  4 Mar 2024 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KV0iCKRE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B698A47A6F
	for <linux-spi@vger.kernel.org>; Mon,  4 Mar 2024 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709567791; cv=none; b=MWqScHjgCy9JTPqFim+TzXwjw6rtbV/oWFEaFSCXM3bqj3gOqy+EJN0l0klE/DDnTqQfNnMvvpP5aZEgWv/yexbte6aQtWwGFpP0p/nVKvxrH3WdAuyQyyOJkryvNvfubW9n04QX8pB576OMJwz9CaU34efYM1l8lZ7vnle4IfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709567791; c=relaxed/simple;
	bh=lRly/biDJMMVVIZFlX+uTgouJKdhMLyljyV570BZOqs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=pJ3pXxVkRYfq7QyVWwOB6opU/+w7B6+BX/xh0SVMT7h0FxKyQwsOlefeePldPpxz0ZFVnfe4vRb+1NBQEyuMW5jFC7yrs5uhavpFNYdJTmyKqCq2mMs50q0C40bF/QGPyPr6iOEXyGruU49EqoepHjp4JcHelIPoKW7r9uKppbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KV0iCKRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A110C433F1;
	Mon,  4 Mar 2024 15:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709567791;
	bh=lRly/biDJMMVVIZFlX+uTgouJKdhMLyljyV570BZOqs=;
	h=Subject:From:Date:To:From;
	b=KV0iCKREs6pTC1vmN6UllmBN+3/TLdhFctRIyrXe6xKGDGtqT+fpvjaEiJCMXSg/b
	 leR3xsEEoHI/JN8WRy577n0kTzPH9qIxhW/726YTarvTnm5nDgfFAVor5pGoA2ne7W
	 sZDOkKcJuE1PKsQZk1TupByYw2mED5AM2YWiPQvR/0mDti9KB/1Q2ZbphNX/hasi/q
	 Xzg3v783YeUejSD540yywQOmwT3vUKkGxfyvSa5JeIg/aXjRYWOl6wK4xSoDR07+9U
	 xpIL9OFI3VSeEo3XDkdipBNhhSDPG49JNoeS3+kKMkm7VfVzAj1zwZMQLmFX+gp9aW
	 hxWwbY/XcYf5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E622D9A4BB;
	Mon,  4 Mar 2024 15:56:31 +0000 (UTC)
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
 <170956779111.16399.2596103486124815396.git-patchwork-housekeeping@kernel.org>
Date: Mon, 04 Mar 2024 15:56:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Virtio SPI Linux driver (2024-03-04T15:43:41)
  Superseding: [v1] Virtio SPI Linux driver (2024-02-28T14:27:53):
    [v1,1/3] virtio: Add ID for virtio SPI.
    [v1,2/3] virtio-spi: Add virtio-spi.h.
    [v1,3/3] virtio-spi: Add virtio SPI driver.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


