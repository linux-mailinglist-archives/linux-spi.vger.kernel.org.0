Return-Path: <linux-spi+bounces-9186-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C9DB11F13
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jul 2025 14:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F241CE1579
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jul 2025 12:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5E92ECEA9;
	Fri, 25 Jul 2025 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZikKh8H"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD682ECEA0
	for <linux-spi@vger.kernel.org>; Fri, 25 Jul 2025 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753448271; cv=none; b=c4RKIt73JSZEVbro+iFgEsWn9eHeU+8fnrZQyMyzdR1Sw6ChgzmKnoHUiRjYwTmHqDnHMUwyxPyMw60vvq48h6rnX3WaJnSoMjr5/lyulFQ6BQk6E6glENviSbccFESWnFEh7MCrZd6LnNM2ZDRDoOwMKbvmBBNS5UJucxeLFRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753448271; c=relaxed/simple;
	bh=VYD4rGAHSmOLFw2qHHleyHA0o+4prfoNztJuVQtqff0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=uIF20W6WqOHyLZjRm5zWquHXrm+DuNIHffbJrJiaYQaYVI86wi91HzPY3b+hb0rV9xgSho3xoO6Wh0ri3WyK8WgejqgxETW7vcrLFqIYXYOAPCDxEJbwMS2BElME6cqlJqzCYX2SEhroqaPGRRBUV+a22ShsqjU8hYNtFqEDZIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZikKh8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBF1C4CEEB;
	Fri, 25 Jul 2025 12:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753448270;
	bh=VYD4rGAHSmOLFw2qHHleyHA0o+4prfoNztJuVQtqff0=;
	h=Subject:From:Date:To:From;
	b=eZikKh8HeyM+EbtdlKsE9FkNKZqhLNOpQW+DCwynUphWWR5fs4FLLA/gkc2T9trZd
	 07Yru5oQdA61e0al8SQijgUdiriMkELYuFcQi1tLsHuzJpnZuc2MzIP/Umcqq9kfJf
	 fruN++9V4W/P7jDp2hNF3XWm6TXIAOc9zldO/sFj+qNfPpdtOcXiQ7CpA4MGmPfHJH
	 qKRM2EV52uelzeDJF+J9puyVTXfb3uGqxD4d3hKwVVxecqOcD4pOj00I9Wa5aoi4C7
	 K5XOV+viSmzErthlCTgB+ApyHia+9R6OdxYlyZainZV+ut8k/LS64L8GV3jiQ36UjS
	 rmUP+hNSMHLww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCD1383BF5B;
	Fri, 25 Jul 2025 12:58:09 +0000 (UTC)
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
 <175344828816.3129387.17713420500903970485.git-patchwork-housekeeping@kernel.org>
Date: Fri, 25 Jul 2025 12:58:08 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: intel: Allow writeable MTD partition with module param (2025-07-25T12:25:42)
  Superseding: [v2] spi: intel: Allow writeable MTD partition with module param (2025-07-17T15:28:51):
    [v2] spi: intel: Allow writeable MTD partition with module param


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


