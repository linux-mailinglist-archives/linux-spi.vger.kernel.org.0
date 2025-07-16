Return-Path: <linux-spi+bounces-9111-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9DCB0733E
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jul 2025 12:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72320167C96
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jul 2025 10:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF4C2F3C30;
	Wed, 16 Jul 2025 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjStiN6k"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3EA2F4316
	for <linux-spi@vger.kernel.org>; Wed, 16 Jul 2025 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661199; cv=none; b=ks2/SlIjkyV7fJpwZHAo7z4c3rqb/+GXW3LVMoF5tKvGKuHRbKks1IeusEJFJ6ySfntzRB9ZsaHRJyiaQKqC4MqJNgleS/8J+zZY5xvVuaMgMKwTExgtBUwLYpdF/AX/SGrkW7EK8vAqF7UKcSP566m7NHGIWXWoYY0xf+akiwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661199; c=relaxed/simple;
	bh=jBroyKltHavKkNuFlisMCmTgkjbirCKVhsJ75k+whLs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=d9gWixcOl5WZateIQ1nutfJRxRPoanjziUOofceSzA600hq5zCleboXt9ZeKgGemiWf+Ic0DnrLNgIoE7Cy5Q3AED2LM8ygpIsRfCkpOuEpOjVACjMq6YULNAe5ILr7auXjnR8JhQE55zw08BJzlk7uE1ahM88GYcvhvMA0GzIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjStiN6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39476C4CEF0;
	Wed, 16 Jul 2025 10:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752661199;
	bh=jBroyKltHavKkNuFlisMCmTgkjbirCKVhsJ75k+whLs=;
	h=Subject:From:Date:To:From;
	b=NjStiN6kpGJTpo5Y+YdGXMqcfASXX249qeUWHPPtjqBF1mb1jmscaOqJUH0MH9sGF
	 EwylUI5SLaJ6aliI2cRERyJBuTy5dKBdwV/0nJ+vgPZ9KNkQlcPCUrZF44mDQwn5D+
	 oHRKFryHJ0CS9lIsRMZYJKmMP2r6AEKWUStzEjfzVdxQ9xyn3mcJU8zGgUvDQZyTHA
	 6ryuLiU0DA6mqFfjF86q+3Vw2IFJyaiAAq+u9R4sxXtszR1iXbXv71cUCtcV7jHlst
	 rS/CysYqEjAqa9YkoJz7Q8h0fJms+FNZFIk1Btgr/Ogqon84HfnJzkn4NlTnWJ/IUC
	 AvyYFVIugdrhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B2428383BA05;
	Wed, 16 Jul 2025 10:20:20 +0000 (UTC)
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
 <175266121937.773888.3575730674060611938.git-patchwork-summary@kernel.org>
Date: Wed, 16 Jul 2025 10:20:19 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: dt-bindings: spi-mux: Drop "spi-max-frequency" as required
  Submitter: Rob Herring (Arm) <robh@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=982684
  Lore link: https://lore.kernel.org/r/20250715202711.1882103-1-robh@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



