Return-Path: <linux-spi+bounces-3427-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBA490CD7A
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 15:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F7D284381
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 13:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB4813C9C7;
	Tue, 18 Jun 2024 12:42:33 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1BC158D98;
	Tue, 18 Jun 2024 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714553; cv=none; b=L2jKlD9wyTYn0b0zfQlslthJNEIJrIMwBZYHhtbqPzQmAwA2UUHq1Z9Vz37E79yuCxjh6CMGN+axNg/EWRhq0n8RHGWr6NrYPZDib8zVliSgnuA0PMMY17jrpVkNw6uAYiOH75WOLmruQitxAM1v/tZgdlObFVLEKq2KXh0w/6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714553; c=relaxed/simple;
	bh=9SxvygKFL84p701wF3qgoxquqaG2gR9pOcvfyEmJNOI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fpVO4s5Rmze3bP1ny/TKh7tWg2G8lyB8pykNTKcUM1oa/V0DnQri6PUZMP9wTlmz22gohX5zBpEfzUAaqsvKTAgaV8a6dUs/GSyg8eHsF6FNBVobBVOX9k2nkmdS71XPZTriTHeym3jeKIpV9J0Uav0I3Af+nCLeamjPiHsyOtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4W3QmR3LMnz9v7JM;
	Tue, 18 Jun 2024 20:19:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 50F2F140124;
	Tue, 18 Jun 2024 20:42:19 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCnLjmhgHFmQ_KpAA--.43023S2;
	Tue, 18 Jun 2024 13:42:18 +0100 (CET)
Message-ID: <727c5fae6391525a03b12e369dc35633fdbefca7.camel@huaweicloud.com>
Subject: Re: IMA Reports No TPM Device
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: "Thangavel, Karthik" <karthik.thangavel@amd.com>, 
	"linux-security-module@vger.kernel.org"
	 <linux-security-module@vger.kernel.org>, "linux-spi@vger.kernel.org"
	 <linux-spi@vger.kernel.org>
Cc: "Gaddipati, Naveen" <naveen.gaddipati@amd.com>, "Narra, Bharath Kumar"
	 <BharathKumar.Narra@amd.com>
Date: Tue, 18 Jun 2024 14:42:06 +0200
In-Reply-To: <DM4PR12MB52310B4519DE2FF70420DA5EFFCE2@DM4PR12MB5231.namprd12.prod.outlook.com>
References: 
	<BN9PR12MB5228AB9BF8A3951983B39EBEFFFB2@BN9PR12MB5228.namprd12.prod.outlook.com>
	 <DM4PR12MB52310B4519DE2FF70420DA5EFFCE2@DM4PR12MB5231.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCnLjmhgHFmQ_KpAA--.43023S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1UXrykJF4xtF13CFWkXrb_yoW8Zr1xpF
	17WanxCrZ5GrW7JF1DWF12kFZYqrWkCay5Grn5A345Cw4DCrn8Wan7Gr4fJ34qqryrGa10
	yr4Iq3sFk34YyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBF1jj59S5gABsM

On Tue, 2024-06-18 at 10:24 +0000, Thangavel, Karthik wrote:
> Hi,
>=20
> Can you pls let us know how to resolve this issue.=20
> Looks many reported the same issue in forums.

Hi

this discussion seems to be related:

https://lore.kernel.org/all/1550753358.17768.85.camel@linux.ibm.com/t/#m5fd=
27cc9c80e90e781ccc5e1c3e693014d0278a2


Maybe there could be suggestions that apply to your case. We can also
resume the discussion, if the fix is not yet upstreamed.

Roberto

> Regards,
> Karthik
>=20
> > -----Original Message-----
> > From: Thangavel, Karthik
> > Sent: Friday, June 7, 2024 12:49 PM
> > To: linux-security-module@vger.kernel.org; linux-spi@vger.kernel.org
> > Cc: Gaddipati, Naveen <naveen.gaddipati@amd.com>; Narra, Bharath Kumar
> > <BharathKumar.Narra@amd.com>
> > Subject: IMA Reports No TPM Device
> >=20
> > Hi,
> >=20
> > We are booting linux v6.1.30 on Xilinx ZynqMP SoC which is using ARM-A5=
3.
> > We want to run IMA on TPM device connected over SPI interface.
> > During booting found that IMA reports "No TPM chip found".
> >=20
> > Please find the below logs which shows IMA subsystem init called before=
 TPM
> > device.
> >=20
> >=20
> > [    0.000000] Linux version 6.1.30-xilinx-v2023.2 (oe-user@oe-host) (a=
arch64-
> > xilinx-linux-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.39.0.20220819) #=
1 SMP Fri
> > Sep 22 10:41:01 UTC 2023
> > [    0.000000] Machine model: xlnx,zynqmp
> > ...
> > [    2.561405] ima: No TPM chip found, activating TPM-bypass!
> > [    2.567199] ima: Allocated hash algorithm: sha256
> > ...
> > [    3.727105] tpm_tis_spi spi1.0: 2.0 TPM (device-id 0x1B, rev-id 22)
> > [    3.764152] tpm tpm0: starting up the TPM manually
> > ...
> >=20
> > In security/integrity/ima/ima_main.c
> > late_initcall(init_ima);	/* Start IMA after the TPM is available */
> >=20
> > As per above comment line IMA should start after TPM is available.
> > But we are observing the opposite behavior.
> > Please let us know how to fix this issue.
> >=20
> > -Karthik


