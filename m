Return-Path: <linux-spi+bounces-8871-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666F8AED3A3
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 06:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA703B4355
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 04:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA9F1AA1DB;
	Mon, 30 Jun 2025 04:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="La+qAzBe"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA36E1A7AE3
	for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 04:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751259443; cv=none; b=bw+glNZXU8+NMweGl1IdG1IrBTySm/6E446bIjCMn0/G+zlOTDMWq7pfM9eqGm4RbpMz8nNGXVhmq+pPKqq1v3pUsd4lxypLafze1jXJ4qO5URCgy1cVrwFyxgbigl7H5crPm0rWYBOIxEpoHr6La82rsK2qH+yi6BFcb91EWbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751259443; c=relaxed/simple;
	bh=LQqpBMaPA9oaTkpZpF7Ncmh/QvYwhZmnlD9/Mpj/gbk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=nwhzBJKgFBPbnacepvwqdGhz9ADF7mvuNNuOOR2wI8qFGUtxVo1+J2wLpwLuPV0/NulK3I4MApJ1bGDDtEHO/L0k8TFguzhHDkyZv78tZ1TPLfYDTZHRrc1EC9FTOXGqQvmQexoc9UNpfmxV4ULNQFakVCGfDGzn3Hxc9jcFfto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=La+qAzBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29ED8C4CEE3;
	Mon, 30 Jun 2025 04:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751259443;
	bh=LQqpBMaPA9oaTkpZpF7Ncmh/QvYwhZmnlD9/Mpj/gbk=;
	h=Subject:From:Date:To:From;
	b=La+qAzBe9tWaYS5v8ylDxu1THUOPlL0O9VBk81tcN3oH4mXdPxeocD+ZcAii4vIgu
	 FpnTQFM/qIn8iblOhLfuvsXHtAripzp1YYYdE/+NiLINUFjG3GucZSCMZz0AYMkZFl
	 FAFF7WqvhTQ0wxusI3NpXdAqjqyIm9QaS7mnO23gog5h04Ay5ursBaFRl9lLcbsZl4
	 G/uYqvj5JDGzqndcpOXIaREmIWORKQzNwGr56CZTt6XL/VFRTSQxOnuCMgzijAYSl6
	 H5WR15QJQezyNHZiA+joct870Gn3CQ5fmHrVp6SFAsNSofjUJdnw0CSAMF+8FDIrHP
	 psyK0vha9ZTNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC40383B26E;
	Mon, 30 Jun 2025 04:57:49 +0000 (UTC)
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
 <175125946837.2890292.629728037064344352.git-patchwork-housekeeping@kernel.org>
Date: Mon, 30 Jun 2025 04:57:48 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-cadence-quadspi: Implement refcount to handle unbind during busy (2025-06-30T04:01:30)
  Superseding: [v1] spi: spi-cadence-quadspi: Implement refcount to handle unbind during busy (2025-06-03T00:21:47):
    spi: spi-cadence-quadspi: Implement refcount to handle unbind during busy


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


