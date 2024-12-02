Return-Path: <linux-spi+bounces-5881-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298AD9E092D
	for <lists+linux-spi@lfdr.de>; Mon,  2 Dec 2024 17:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F9728226F
	for <lists+linux-spi@lfdr.de>; Mon,  2 Dec 2024 16:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751051D9A79;
	Mon,  2 Dec 2024 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VSkN8ZkJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F1213C8E8;
	Mon,  2 Dec 2024 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158641; cv=none; b=SgeO8kb8s0G3k3QtGinnApxfl0UJ69k2lvm+wsA7+hKau2QDWWYHiHptYy8iEN7djLZzS8yXRcgXAEWC9C3MN4Pqai0keBr4HG/PGj3ki09Yw4hsPcp8S1dF4AXksl0jGvuDsBshDhYH9yI9TuVRdMHGkMjMcwCc08n42Lry+/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158641; c=relaxed/simple;
	bh=uJsWqmIq1oa/qJRElqzZus4/s+VgdKlbkG9mgDS7sNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SKHkHff16EvDT3fMtWcaota6uaNiNeKz0gsPUU6CO0GuB6gsMnSo9DxGuC4Al6uagzBnsTZ8f97vK+hifR2TZRjd4IBPNm4WcLvex+NVcMT1QdvtyICMmLa9OQfVtQVaG0mXdXoNnzSVsGlVuSre3fuwEmUPs09mKPNCw+F8CH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VSkN8ZkJ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 18B1A1BF206;
	Mon,  2 Dec 2024 16:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733158630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwJhyHk0KFMT+SspT26kxCXdvr9xbBBJKrLs3UwpEic=;
	b=VSkN8ZkJeUeTRw2LmDazBUhNapQ6k5z70UoeTPWZRwkhVI3EDrH3qvNDYylCHOwxXU+44g
	JkDY8NAL7vKRRrcXxul0ZWkGjVJ+mePFdRPQeXa7YU443Pcd2ev9PkJ+wPuJ46ko83NYSG
	ltHDoK7cIkCRsBIdF3JJRpqV/Z/Of5qQG2rn22z7fZvXwrRdY9mVwy2sZ9mA/WaKJHZR/Z
	vep6asofT2F50lOkz1I/yPjE3/eYBGwrUAkx0FC4hnlRO00WPFO89Besjz/bJfIjtFPlnI
	9AD+bLY0RrGVDRDQObNyFXhxOepoG90Smm25dLB67JH7SXinixFfbhFtz/jzWw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <andersson@kernel.org>,
  <konradybcio@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <manivannan.sadhasivam@linaro.org>,  <linux-arm-msm@vger.kernel.org>,
  <linux-spi@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <quic_srichara@quicinc.com>,  <quic_varada@quicinc.com>
Subject: Re: [PATCH v14 0/8] Add QPIC SPI NAND driver
In-Reply-To: <20241120091507.1404368-1-quic_mdalam@quicinc.com> (Md Sadre
	Alam's message of "Wed, 20 Nov 2024 14:44:58 +0530")
References: <20241120091507.1404368-1-quic_mdalam@quicinc.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 02 Dec 2024 17:57:09 +0100
Message-ID: <87mshe58gq.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Marc,

On 20/11/2024 at 14:44:58 +0530, Md Sadre Alam <quic_mdalam@quicinc.com> wr=
ote:

> v14:
>  * Updated commit message
>  * Fix spelling mistake
>  * Remove "inline" from multiple APIs from qcom_nandc.c file
>  * Move '|' in qcom_param_page_type_exec() APIs at the end of line

I guess it is now time to move on, I can apply patches 2-5 and share an
immutable tag. However, due to the frequent inconsistencies observed
during the lifetime of this patchset, we might be slightly more
conservative than usual and split the patches over two kernel
releases. I fear there might be annoying fixes on the mtd side needed
because of some side effects. Without these, the spi tree might have
broken qcom support for several weeks. What do you think?

Cheers,
Miqu=C3=A8l

