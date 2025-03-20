Return-Path: <linux-spi+bounces-7252-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4A4A6A98F
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 16:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32DA8188EDB6
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 15:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63DC1E3DEF;
	Thu, 20 Mar 2025 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="AVvw0FmX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2881E25F9
	for <linux-spi@vger.kernel.org>; Thu, 20 Mar 2025 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742483746; cv=none; b=oB9qwJ2Wz8wOISbrTkm/aC2D8KawUQZPv/9OMKA5KKp/PCLdTtPl9c9krq782/zku0NyVrjuz6lt493RTs7YkSLT+txoT+ESk+hUdxTM8UH9CzkUkYGu65nK+9lzCaPCyjmOfDmZCZn2Gk7ZV/9XYtQ8dzX6TR783zz0E1fjz+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742483746; c=relaxed/simple;
	bh=+vjOtHSatNVIU3WxYisjoAO0G4H6utMwEf+kgJLNLGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5sYrOwNI/6IQg/tCgQ4lvsrprDKHRw0vZmJrft9Drp9qWtj9gxfeJiYsRowvsbYKRxNq7WxZg85O6S1jlQ1HAoKkLY/Wcbok7RZlQ4boTSaiM+Tieaqn4uz/Rv9DP15JrE6/ics+Sxrd3jHIeUp1KKsYlsX5S8fQOTpOv9cNJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=AVvw0FmX; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 95BDD1484E06;
	Thu, 20 Mar 2025 16:10:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1742483421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KbBt8LqXCurgxY2vjrCN0Yd0RXecmPkAzvq6cM3/PXM=;
	b=AVvw0FmXXXQC8deZ9FjV+1djreDyY9mSlpv28iafAWeqEy+4EE0IME9Xwtz3EEEluuCRW2
	w0vzSB4bG8M0vAAjAowMB4hY0JsZn3CqsvmgKSczYjUvD8BvsEOeaUGT0eedkxpcx0gnwd
	JRGwJiRknl2ctcpKZ4DbcC+WzsenLlGgmf2mhk53LgVl++9ZpZuTIykArreUraBJX/+qnI
	IlKOaFS70CjfurCZNhCcM31l+f5JVGEGtihq+AEI5VgA0iqxjPFubYT1XpdwVPUqyKKs1A
	b53eSMx2dgNLtYFiE8FUOUjJvA8nMmmbZ+95yvksirPGgeQ8rduZ+h5ixdYODQ==
Date: Thu, 20 Mar 2025 16:10:13 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2] spi: spi-mem: Introduce a default ->exec_op() debug
 log
Message-ID: <20250320-cactus-laborious-64dfd1998b72@thorsis.com>
Mail-Followup-To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20250320115644.2231240-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320115644.2231240-1-miquel.raynal@bootlin.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Miquel,

Am Thu, Mar 20, 2025 at 12:56:44PM +0100 schrieb Miquel Raynal:
> Many spi-mem controller drivers have a very similar debug log at the
> beginning of their ->exec_op() callback implementation. This debug log is
> effectively useful, so let's create one that is complete and concise
> enough, so developers no longer need to write their own. The verbosity
> being high, VERBOSE_DEBUG will be required in this case.
> 
> Remove the debug log from individual drivers and propose a common one.

Like it.  Especially because it allows this kind of log together with
drivers which did not have such logging yet (like atmel-quadspi).

Tested-by: Alexander Dahl <ada@thorsis.com>

Greets
Alex


