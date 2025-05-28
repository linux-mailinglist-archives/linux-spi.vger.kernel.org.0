Return-Path: <linux-spi+bounces-8320-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5D8AC61B0
	for <lists+linux-spi@lfdr.de>; Wed, 28 May 2025 08:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCF697A9BC0
	for <lists+linux-spi@lfdr.de>; Wed, 28 May 2025 06:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB112101AF;
	Wed, 28 May 2025 06:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ffo52/UJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6E6A31;
	Wed, 28 May 2025 06:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748412701; cv=none; b=eFNhQrZLSqbqbxJ4SzZjUqu5oWjRCJ4MpJSNUV7TTjs8BlAT9l4/P8l9EP8EbTqsO9FArcqK/xyyUDfs3dCQ5W6XSU5MgNfbIvTGcQaShsJ6lPaNyHBwZd0L+0LGa3gxjDmvkFSDQo6R4KgR/CJ5CFsxb7IZi0rTmue1DbsvNM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748412701; c=relaxed/simple;
	bh=GCinHpWj1YalgHxNp+j+p4XLfrAMSRv4bIHGzfbwwXE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gA6KEJk7n8xmze1o2fOcc7Y5dxb3LzWzJ8yoGiiyjOsLcGoMc0Z+RP9a4HUmyIl9cXnIRdtrs9ewHBToZps8A35mHKkME2zgKjEkCB2tzrVUQ508x7BsnuK9Tul6MeF3deFWaHmXyxcy48NxMVj173+uDWOFsEKnEngE1ONX+g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ffo52/UJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RKFpu9016904;
	Wed, 28 May 2025 06:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M2fOF6/NsrkitikutpZi4P4ogLVHf096azvULrGKkXY=; b=Ffo52/UJ7/yuZnSU
	7paK4qN5ohPBNPCjSai9R+mjjR2bLgFHbWJYlbIAQnmRcwT03F6UtEx+BN8CFZFQ
	v44U6B/ojJukNoxlLub2AB6SSZVUrH6JelhsANRTnYxDRa/5lY3vqYgm5rLAoOK2
	IFOPlgwEGfJJRX21Btn1iuJLPntBf/2eERhtdf7XDDWCbPndVKW7fJaAynNKviq/
	EG6emiweMNA/PwNIbn7zj8HTURwsj45WaGo412/F0x1bId7vs/+LGlF2KNlTbvXe
	w9DsuMg56KB4Bc5cltdICrwVNwUSFABEdx+j90QDPU8eNefd4lySIm28I48j/8fj
	Kf214A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46vmgcwpyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 06:11:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54S6BIYh014820
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 06:11:18 GMT
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 27 May 2025 23:11:17 -0700
Received: from nalasex01c.na.qualcomm.com ([fe80::88c3:e10b:adc4:a38f]) by
 nalasex01c.na.qualcomm.com ([fe80::88c3:e10b:adc4:a38f%11]) with mapi id
 15.02.1544.009; Tue, 27 May 2025 23:11:17 -0700
From: "Lakshmi Sowjanya D (QUIC)" <quic_laksd@quicinc.com>
To: Gabor Juhos <j4g8y7@gmail.com>,
        "Md Sadre Alam (QUIC)"
	<quic_mdalam@quicinc.com>,
        Mark Brown <broonie@kernel.org>,
        "Varadarajan
 Narayanan (QUIC)" <quic_varada@quicinc.com>,
        "Sricharan Ramabadhran (QUIC)"
	<quic_srichara@quicinc.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] mtd: nand: qpic_common: prevent out of bounds access
 of BAM arrays
Thread-Topic: [PATCH 2/2] mtd: nand: qpic_common: prevent out of bounds access
 of BAM arrays
Thread-Index: AQHbzZdYfct6aVWiz0mO9tgTnO5SQLPk7/SAgADcJoCAAcYsIA==
Date: Wed, 28 May 2025 06:11:17 +0000
Message-ID: <f467dcc6e92149b8b46ca8a879d36d6c@quicinc.com>
References: <20250525-qpic-snand-avoid-mem-corruption-v1-0-5fe528def7fb@gmail.com>
 <20250525-qpic-snand-avoid-mem-corruption-v1-2-5fe528def7fb@gmail.com>
 <8ab1e48a-f698-9859-3992-6a26f63d62f1@quicinc.com>
 <b9134a1d-3dbc-4cd9-b22a-90b1c8934ce9@gmail.com>
In-Reply-To: <b9134a1d-3dbc-4cd9-b22a-90b1c8934ce9@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Xal3xMLZHkDh3alf69vUZ6Iak3lMKEGi
X-Proofpoint-GUID: Xal3xMLZHkDh3alf69vUZ6Iak3lMKEGi
X-Authority-Analysis: v=2.4 cv=Ws4rMcfv c=1 sm=1 tr=0 ts=6836a907 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=xqWC_Br6kY4A:10 a=8ewgkwWz-JgA:10 a=8nJEP1OIZ-IA:10 a=dt9VzEwgFbYA:10
 a=pGLkceISAAAA:8 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8
 a=sozttTNsAAAA:8 a=JfrnYn6hAAAA:8 a=r6KVuAiU_dlV6dZd_TEA:9 a=wPNLvfGTeEIA:10
 a=TjNXssC_j7lpFel5tvFf:22 a=d3PnA9EDa4IxuAV0gXij:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA1MiBTYWx0ZWRfX9eOJAwKHTo3/
 KvqLuZBRwdza862lK9i7cnE3d4uzW4Jepic5Y+zvutM0IStucDxou+rWlODhMFCxGWwkWToxsEF
 KB2RBtHZoQXuy9t9nY61U7Kj241QKGY7euhVCkLLTXOg3aHeveMs9zH5pGdqbmZXr4wylmVBcEv
 kIZOF8EI+yNIapxMJYkJUInygrj2r7qqg2xrVXtU2vuxxiIEehnZJjpLqfxk+b6CR9CmBQTNiyI
 SDi/KFJ/SmpUawW8q2x4x+oEi9uxgzCQHmd76+jmFegj5VcX7o/ZdiDNQaYzM3wd/YPg3mAJkiR
 r+tvd08NV6h1x0NPL1nr3fJJbfjkJBmzOj/0YNtrABOXcwGBZ0uuqfKxeHFRwmJahPTPu1mMS9y
 j+gTQGM4PW61Y6LwxPYv0v+4GqQz1UHKS620Yp3bmI/xnCQtzuhKUdMbekjBJhIG1T4Yb890
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_03,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505280052



> -----Original Message-----
> From: Gabor Juhos <j4g8y7@gmail.com>
> Sent: Tuesday, May 27, 2025 1:31 AM
> To: Md Sadre Alam (QUIC) <quic_mdalam@quicinc.com>; Mark Brown
> <broonie@kernel.org>; Varadarajan Narayanan (QUIC)
> <quic_varada@quicinc.com>; Sricharan Ramabadhran (QUIC)
> <quic_srichara@quicinc.com>; Miquel Raynal <miquel.raynal@bootlin.com>;
> Richard Weinberger <richard@nod.at>; Vignesh Raghavendra
> <vigneshr@ti.com>
> Cc: linux-spi@vger.kernel.org; linux-mtd@lists.infradead.org; linux-arm-
> msm@vger.kernel.org; linux-kernel@vger.kernel.org; Lakshmi Sowjanya D
> (QUIC) <quic_laksd@quicinc.com>
> Subject: Re: [PATCH 2/2] mtd: nand: qpic_common: prevent out of bounds
> access of BAM arrays
>=20
> 2025. 05. 26. 8:53 keltez=E9ssel, Md Sadre Alam =EDrta:
> > Hi,
> >
> > On 5/25/2025 10:35 PM, Gabor Juhos wrote:
> >> The common QPIC code does not do any boundary checking when it
> >> handles the command elements and scatter gater list arrays of a BAM
> >> transaction, thus it allows to access out of bounds elements in those.
> >>
> >> Although it is the responsibility of the given driver to allocate
> >> enough space for all possible BAM transaction variations, however
> >> there can be mistakes in the driver code which can lead to hidden
> >> memory corruption issues which are hard to debug.
> >>
> >> This kind of problem has been observed during testing the 'spi-qpic-sn=
and'
> >> driver. Although the driver has been fixed with a preceding patch,
> >> but it still makes sense to reduce the chance of having such errors ag=
ain
> later.
> >>
> >> In order to prevent such errors, change the
> >> qcom_alloc_bam_transaction() function to store the number of elements
> >> of the arrays in the 'bam_transaction' strucutre during allocation.
> >> Also, add sanity checks to the qcom_prep_bam_dma_desc_{cmd,data}()
> >> functions to avoid using out of bounds indices for the arrays.
> >>
> >> Tested with the 'spi-qpic-snand' driver only.
> > I recommend testing this patch on both the IPQ and SDX platforms, as
> > the QPIC raw NAND driver are utilized across both.
> >
> > If you have access to IPQ and SDX devices with raw NAND, please
> > proceed with testing on both.
>=20
> Sorry, I have no SDX devices at all, and unfortunately I can't access my =
older
> IPQ boards before next week.
>=20
> >
> > Otherwise, I can handle testing on the IPQ raw NAND device and
> > coordinate with Lakshmi Sowjanya D (quic_laksd@quicinc.com) for
> > testing on the SDX platform.
>=20
> If you could do some testing in the meantime, that would be superb.
> Thanks for that in advance!
>=20
> Regards,
> Gabor

Tested-by: Lakshmi Sowjanya D <quic_laksd@quicinc.com>     # on SDX75

--
Regards
Lakshmi Sowjanya

