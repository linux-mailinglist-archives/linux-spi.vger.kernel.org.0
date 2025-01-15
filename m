Return-Path: <linux-spi+bounces-6361-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE65EA12ADB
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2025 19:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF7C166872
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2025 18:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FF21D63E6;
	Wed, 15 Jan 2025 18:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HL9OoHot"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B99161321
	for <linux-spi@vger.kernel.org>; Wed, 15 Jan 2025 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736965819; cv=none; b=XfySiGx+YNFUThy/x+FsSMO9HPMWuncT7yhKzrNFQAdVlSBoqa0HByt6JHX8G6Gc2d8QhzkN380pM26FoK+G8bKqZFnwKYK0QA7kdpdHLFB2BzwFvR8HdpjYhw/pz20T8n2o1pr8Wk6XZCtRCGSadC+JR3FVM636m7emhuo8QPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736965819; c=relaxed/simple;
	bh=2IeLlHk2idwVKBXU4FgWrO2CoxQDyfsGXbk96BDsC8A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C/fxQT3wnZgz+4LqpznwcChzhpAqJDHvTYfXnht1nMV0F7FOWathJnTpQNZOk118QLyCAkj4Y6PVpfjFUL4oRaXIairkVhiY7kcpNGPYmkrVsymwG9ZmF290AFkkcZSM2TaXxnuZ/qNjr6OSXPp5QIksn5GIKHtge7MmnUTvSLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HL9OoHot; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3DBE11BF203;
	Wed, 15 Jan 2025 18:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736965815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqBj7+G6NFiicKFyViQdTNE8H5JWq2ncE2tH/y9s9To=;
	b=HL9OoHotnvd6k/ocwHWV9azeSaVwqMLnUmrkYGe5HvzXG6m3NHStbpCemgE8jXfU77pCCS
	zfrEBNL5Y7TCDg2jKiBAqx4FNiFt0YG0uJ7ns9LoohDaXeEkyxZYGfrCeMvQU5rpLaceKp
	8vFGVHgchHmQSDEmmj2idq6IBbJh2EfBCe1n68k2uBZIoBGv/m5JxzA+3AGJUMw7B08tiM
	YwlIhQaIZYcMahFMxRU+V4hIgefBwSxDMEEpysW8PAZfj57QRM3JfBShBwqjRxdqFu4Zr6
	m4zqhK2XlwECuGngCJ7tB1T/5O7+Rw+mFVVB8hrHCC6FH9Ch1HMJl3UOPPvbeA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>,  Nathan Chancellor
 <nathan@kernel.org>,  linux-spi@vger.kernel.org,  llvm@lists.linux.dev,
  patches@lists.linux.dev,  kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] spi: amd: Fix -Wuninitialized in amd_spi_exec_mem_op()
In-Reply-To: <a20383dd-57cc-4c0d-8bab-09a9260f2378@sirena.org.uk> (Mark
	Brown's message of "Tue, 14 Jan 2025 15:17:59 +0000")
References: <20250111-spi-amd-fix-uninitialized-ret-v1-1-c66ab9f6a23d@kernel.org>
	<173678670956.71125.2320310623665812760.b4-ty@kernel.org>
	<87h661u2z9.fsf@bootlin.com>
	<a20383dd-57cc-4c0d-8bab-09a9260f2378@sirena.org.uk>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 15 Jan 2025 19:30:14 +0100
Message-ID: <874j20nd55.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com


>> I'm wondering whether it's relevant to pull the branch you shared
>> as-is. Do you plan on pushing this patch of top of it? Or shall I wait
>> -rc1 for the SPI NAND part?
>
> Well, it's not a branch but rather a tag which complicates matters a
> bit.  I could cherry pick the patch over and make a new tag I guess?  Or
> you could just not do allmodconfig builds with clang?

I'm worried about the others, if Linus happens to pull my tree before
yours :) I don't specifically use clang :)

> for you to fetch changes up to e896c04890aeff2292364c19632fc15d890d436c:
>
>   spi: amd: Fix -Wuninitialized in amd_spi_exec_mem_op() (2025-01-14
>   15:07:11 +0000)

Pulled into nand/next. Thanks a lot!

Miqu=C3=A8l

