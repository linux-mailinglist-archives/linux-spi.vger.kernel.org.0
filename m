Return-Path: <linux-spi+bounces-8307-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E1DAC48B3
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 08:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C622A3A5A22
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 06:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15031FBCA1;
	Tue, 27 May 2025 06:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pcun58Qi"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB811F8747
	for <linux-spi@vger.kernel.org>; Tue, 27 May 2025 06:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748328970; cv=none; b=ilR2YozR27b1Kfp1skeeF8Hj3uJsHQ8RKPpMlX9eGtyEWXYkCKklVDvKxlyX7tsfRVKTUcD6iHe368YmzSZaelCDHuWs/f+LUjqwGf9ltrVTqZifLShML+IpgkTY7svPaD20960jQU1IOZFv+WmXJUkIgv9GTLbrjdGjhWwqgwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748328970; c=relaxed/simple;
	bh=l7riBZkr8z9jLVVvaBfpAnT4Xpmcge3GYtx4hahq8Rk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mTIfnS7lLtN0G/zZ0wuUsSOYHaA6f6cMV6nAZ8XbmWzM9FwIBr0RgpK051wNSgnPIUpy2WXlbun3bZAeBaUBRuab8d+aMUzJo0xy3gImdk3Two+NQDs3V2XEfztkE7v3eQtbDIDIg/DQMDyUqu1H3q/ttSk94aco3fDRgHQGGWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pcun58Qi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32161C4CEEA;
	Tue, 27 May 2025 06:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748328970;
	bh=l7riBZkr8z9jLVVvaBfpAnT4Xpmcge3GYtx4hahq8Rk=;
	h=Subject:From:Date:To:From;
	b=Pcun58Qiiam5Yfu6yQAx8WapGMaMTyucEJEB9RDEgpjwOJlJzVFhu/VOcklzhJNks
	 rSn2ao9Ho/LE4S2WN4lPavC7aPGc03eOwl8pyUPxKrqd63PLPqiu2MgPAirppBsIkp
	 I6pvBZl15j7Ni7j+HQz+R6FCTUjRG7U9nNyn3m4X98NQBT53jLsuv7bxU5fQKXI0KL
	 OROikQBoRiree5zrQRemKjZDayWH43yQf1n5GmQ5av+oqV3ITfTjYqxKR01jZiNeBa
	 x9HjqtbSe7jvBbvyY7oPPVmKoeoXgsorcV+VX9YFm7G6GWvv62DE+hqYR2FHW2sz5d
	 Zev3V+FWePdzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD56380AAE2;
	Tue, 27 May 2025 06:56:45 +0000 (UTC)
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
 <174832900427.1184552.468542412022926583.git-patchwork-housekeeping@kernel.org>
Date: Tue, 27 May 2025 06:56:44 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: dt-bindings: cdns,qspi-nor: Update minItems/maxItems of resets for Cadence OSPI controller (2025-05-27T06:34:38)
  Superseding: [v2] spi: dt-bindings: cdns,qspi-nor: Update minItems/maxItems of resets for Cadence OSPI controller (2025-05-22T10:47:45):
    [v2] spi: dt-bindings: cdns,qspi-nor: Update minItems/maxItems of resets for Cadence OSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


