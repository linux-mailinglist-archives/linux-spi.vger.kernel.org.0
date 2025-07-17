Return-Path: <linux-spi+bounces-9120-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D4AB09138
	for <lists+linux-spi@lfdr.de>; Thu, 17 Jul 2025 18:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C5B5A2C4B
	for <lists+linux-spi@lfdr.de>; Thu, 17 Jul 2025 16:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F261DBB2E;
	Thu, 17 Jul 2025 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5nU/tFj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6332F94A7
	for <linux-spi@vger.kernel.org>; Thu, 17 Jul 2025 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767896; cv=none; b=paXuvLtLOb0GkvcX3ndaprZRN+uKrgOGu6IYMve5shGiAM2ABbioOzP4NvOf996k/PZA6xntbcP1HQ1AwIiMuBoaP3gBlQqXdVr65YoL6dkLHVTcigHFKK7PtdUSflk2oka8X7a/Q2Gqb9BCjOu7nzPHOF0dqIieyzwUk8n8Gpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767896; c=relaxed/simple;
	bh=yHsiV7X7WKnmRjS7CCkLKB95G8P41c50xhlAhOSLrtY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=JOKVEt2yozeSIp5IhiGJ9j9SSU/CP8VSKcbB3wZdSpKPD9Esyl9+2Zhgd/CdyACDXeHHcb1pglsHYTEdgedm3NFUBNyqgplNbcggAXceeC9lgHgBBsy3OXnb/Xb/FC9OzkBonguoFjw/VjcF1L9REbo2kCxlMBEDkRncrag/nPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5nU/tFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1172EC4CEE3;
	Thu, 17 Jul 2025 15:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752767896;
	bh=yHsiV7X7WKnmRjS7CCkLKB95G8P41c50xhlAhOSLrtY=;
	h=Subject:From:Date:To:From;
	b=r5nU/tFjhCc5qrGbd+HNmYVJskUFrtJzuxEfbw2qEGUmG1SCUu9hpDcMhL3cZYHdd
	 xzXC67ncpaeUy7GNVmft+KnfVsALCjMUT3sQq+8VY0M8GRxxX7ERfL8qfQjr5CL9tX
	 ovtVP8ZcbflRclfvYWUkCFXriyBAW/OJIRkIhmNfUZ0jCho8gLNV3vGBNrlludH75x
	 nDhkbv0HlMSTsmKze2HvY0GNZcy/QffKE1Y0dbQJQ94ftNKmXDBIzDu4z82H5NA6Vk
	 FMqtl6FiGZ51Zj+88gn+uZQ2W75TkjEaW8FeGvhWbqQTOi3hL6zJcm8vZZiSt1l7Hh
	 MlxvnqgQBCN1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 36D04383BF47;
	Thu, 17 Jul 2025 15:58:37 +0000 (UTC)
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
 <175276791575.1981765.17181388167248585365.git-patchwork-housekeeping@kernel.org>
Date: Thu, 17 Jul 2025 15:58:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: intel: Allow writeable MTD partition with module param (2025-07-17T15:28:51)
  Superseding: [v1] spi: intel: Allow writeable MTD partition with module param (2025-07-15T09:50:07):
    spi: intel: Allow writeable MTD partition with module param


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


