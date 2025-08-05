Return-Path: <linux-spi+bounces-9297-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FEAB1B8DF
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 18:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FCA3A4185
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FACC25A631;
	Tue,  5 Aug 2025 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bM00PYPN"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B5745C14
	for <linux-spi@vger.kernel.org>; Tue,  5 Aug 2025 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754413106; cv=none; b=S1D8gv8LF9IpyyP4/D++foJ4x2rGjXHi6xUl0hm3nqhE2VnzCMFosWnvOg/foIT4NvrJLyMHmNblWbmeoVx5hLkAEryeK+D34brbk9e0t6sw5ySH3OPkf7OFxYx9f5Fx5wqC4h8TRMyt+ONUmuOdcH8lzjNGrzajwKbvNa14Pow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754413106; c=relaxed/simple;
	bh=fzBK/RQ9duW5Ys7tdO7A6bVdg1ariASn032Iyj5CMqk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=MU0pRGcOIF3Mzr5v/UDBjC04g2V9tD+b4167lkYL81OKn3GyXT5eKMsBjCfJ5EuPeuoYNSgok0sRwnmy76/NipRuC8MeQqfq26J1vgxgTqwIoRn6zU4q03bMYVmvMSyBg5qLu/e+5GCT19O0nzXkuWx0omqsFIu9zGgLyYP0oLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bM00PYPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6BBC4CEF0;
	Tue,  5 Aug 2025 16:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754413105;
	bh=fzBK/RQ9duW5Ys7tdO7A6bVdg1ariASn032Iyj5CMqk=;
	h=Subject:From:Date:To:From;
	b=bM00PYPNmf0BuewWLZtMlRjml6AIR+8INvMXLAmEo6YxH0K7erUPg5cen/rvt94rK
	 dQNWHKibIBVowsstajXbUeMOtd28J71ziyAENs2bKpWwv5p6Gd15wboIZ7WtcZxAJn
	 S2WpIG8dKW6Hkg4YwzCE3dkI4ennRCdiVi+OncwScei50c0M4YaV621WS5qY4rOXE1
	 Ua1n1iYaf7g4PIIApvPiFyMcZdtVccYxxEb8rccj0x9lGADwrLJtripYOjqQX3TVI4
	 YrSLCyKlBe38Sw2RMijhzNVxuMx+786ns4+UnYZBdDnzXFD0qscbMCdITsCFCYZ0kO
	 aBE9a25n1E2Sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D9B383BF63;
	Tue,  5 Aug 2025 16:58:41 +0000 (UTC)
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
 <175441311964.2094573.12445584989449144228.git-patchwork-housekeeping@kernel.org>
Date: Tue, 05 Aug 2025 16:58:39 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-qpic-snand: fix calculating of ECC OOB regions' properties (2025-08-05T16:05:42)
  Superseding: [v1] spi: spi-qpic-snand: fix calculating of ECC OOB regions' properties (2025-07-31T18:11:32):
    spi: spi-qpic-snand: fix calculating of ECC OOB regions' properties


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


