Return-Path: <linux-spi+bounces-9456-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B99E3B272DA
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 01:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E8756825F
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 23:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFD228751D;
	Thu, 14 Aug 2025 23:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="sSFoDVd4"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023100.outbound.protection.outlook.com [52.101.72.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36E928853A;
	Thu, 14 Aug 2025 23:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755213153; cv=fail; b=iIVIQogWslNoAllhszI6ozMTIGR7ZKZsmVOYQ7D3HtwhW5bHms3csO5UxBSgoqwL5oP5j5MfY/IkEFYItVKXadmAjpeXdf0kcqHoPLPS+AvGAquY1R7lqxR/vGwKtAlBbVgpuFnz7sn6UsnR2uRfdeeofZeHCQSg21nhhjK8+Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755213153; c=relaxed/simple;
	bh=7Di+riiC9wI2m3/OHwXQDXEihyM3lzG/d7EF/zp7XNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p8lVDR/+ZNk06Q5hX0B96uitCNxx4xG8rz9k8m6K+lIaFzEO3czuSVkPqB4yb52XN/iZX3kDUJYRMko5Ep40HiDl7quOzkpVrPo/KJPwkDMJ0qN62OlfzFT+feeUpFpm6LpLKKFO0O9NqpqZCVTKa0j7CQUTUH3MkmkaN4bJmxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=sSFoDVd4; arc=fail smtp.client-ip=52.101.72.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5kLG/KL4IeF5SqFGSrmD2lkEngnrIi8HwLGjLuVIkUPZuVjhNA2U8dW663MIKt+nypu7WfEJ5nxi41h+prwWJ9Z9gKiAbVmUHTwObdjygXJ6lY0CEwYmwMeOkhtaz6N4Au0vBCDgVa+rtDt+nAzHaNdUn6zwnBD0avW2jqeVpjUW5+NJIPslQ6d3bLA1+MBczi7Gd6YEOFLEJHHmUAgsuXDsMCSGXLtThpsXzTSxVDqb6MEVV1WeTRzr/+Tc0kUoQ+NeN3UPJLRlf0sklWEvR4CmgGI5u54WN2upsKvw7hPsaZ1R8/TU9Ifgt8kUx6SPC9cN1qoZnkcoYN+hvr6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9F4TvGv5hKURB1CFZIMDhzyjZiuUjppj/nUeQHHJMn0=;
 b=mqcRf7xdTlv1nLBehvAi04zk2Vd0mHNs9bwEaBllW5dUjCGSZRnij99Dm/06NtuR3ia8/xUEf3a8JgsrvVItLbRwDYY9OfSsqY/1f2bKPkMXGt1mE2W9jKW0Bl3yAReSOIHLf+fFLmrrktRlRFGqcEYmMYbuMis15ZzjfppoY6TMgZ4GA7/erChH3dCKzy8t0I6T7/fvyyo2/ij75OxENHVs62SJ2CYuF16hVdFWZ50vBae72l+llmBXEW03Reyhz8puyBCsvDLvnr2IWVvKOBxaqo5pzpVunLfiYyvjUpXcwgOdYZV9syTDKevDymAma2I3Scdi8Ktr32JuqcsPiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F4TvGv5hKURB1CFZIMDhzyjZiuUjppj/nUeQHHJMn0=;
 b=sSFoDVd4/7ODx/jvvL/1AoNYsqtjGDmLWL+xeowNi8NbQj7XlPy48KLBG+Lr+rQvq4CahDQm3Sb9tF4H8iVBV6H0pjThh2Hz9E160q6cCqMbdIWwweD2MZ45mH6AzqenL3n3uAqwlCxexvsJPJo7AsXpVgJ09/nz2Hxzv4EFLZ0adOEONg2UMJUwxpdhjFZ4tqfzexFV/+vdmA/hfaRow8syKLVCZ2TM0is/c50Bh1BTs9NiWtoJBY4eMUfp+RJkoEgkvwfO6caL0kakFQcQikCZZZn2Sl3gOoW4o8ulv8PqIF1rwVwULF63eUECbyttxxEo165bMtUZWq30G6qv+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6032.eurprd08.prod.outlook.com (2603:10a6:102:e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 23:12:23 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Thu, 14 Aug 2025
 23:12:23 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 06/13] spi: airoha: fix reading/writing of flashes with more than one plane per lun
Date: Fri, 15 Aug 2025 02:12:03 +0300
Message-ID: <20250814231210.4174427-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814231210.4174427-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250814231210.4174427-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 41fc669d-8572-41d1-cc2a-08dddb8806dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QuJ+wWmBgDuTnSJ9jAk394zHVzxSXShzrvSwPs6jWS+ibTzTDeatXwTlIFjm?=
 =?us-ascii?Q?oqKcpOjhCZVJ/tDjHJr/9H6fc8IYTwfolVYyESI1qj3Or8DYDf0e/6djEI+a?=
 =?us-ascii?Q?UGa2cwJquhTc+09NZsfwYNMdpCU2DLQvvsISCysRGNCGKzawlAULoFBMD4Qw?=
 =?us-ascii?Q?ezOA1FJjedyVEUM2H8SeS3+4vgAKH/ctyFr7D43E/12iZ9oO1KZATJub7V2z?=
 =?us-ascii?Q?F7La1+OvR+Vies8Bo7SIO5VjoKWEnaj5An7tOTL8+AAeudsMS3v7gnZpf+yN?=
 =?us-ascii?Q?SPd+ExhTGSvKBavRGKN/1kmpk6cNro+s2PDYhrvvVjq0BkN6iKP51tROj8K/?=
 =?us-ascii?Q?RpEToGqrxU8efRoJfboPoqVYfotk4Xy4ud8K/uDfJUQ2vejOBb068Q/jHBzn?=
 =?us-ascii?Q?9TDj20lYfg0Yj4dwdhirqcmCnXIx/XCOxed/OYvKXc3vB4K7tB+q2TBeVtct?=
 =?us-ascii?Q?m71VvfRpkf2TYzXpG+j8oCCI0mJbDnY3hxaVUG4pw+wyC02uwr3duXv6k30E?=
 =?us-ascii?Q?uyudqUjUawFZjJDr6EE5JXAFUOtks+MfxIVdTu7Fj92DF8RYBSUWTfpBxwdq?=
 =?us-ascii?Q?aS/IwfOhVTofSPsy8kAX8f+5S38QEotrsiGjqXdiZFL3eTKTO0RaoIjkjiCf?=
 =?us-ascii?Q?Xz1aX0VKdc1oPoaAH6ftzqKElsSLeHJcZ86wS4uuc3OxU3L6XSDZK/pMqAGo?=
 =?us-ascii?Q?azMyCwTS3McAgas19ve4MBfwecIck55EsbCbTSvudDc+Nq9/36rZijhNpURX?=
 =?us-ascii?Q?2jwU1vv/wLSf1G099WE0+R0YiHx9Ffw/jxcawM7yNn3VeXxkbHLCKrF7nEMX?=
 =?us-ascii?Q?YkyP2ahP7GoQ9SJj31frtBkaABufbTdmMJRy7KdFPFuh+u9Hg5uXy7sCcUVe?=
 =?us-ascii?Q?QiQxgNbNTDpTW0cGeo3DYD1XeGMFg7DcmXDj3fwq6vzFYoEDZJllWU3WnSxU?=
 =?us-ascii?Q?nXWkoSyLwf61AxmflkzfKa96JwAiClH5z6uoESvhOd0bXASuz0NpwP83Cv4a?=
 =?us-ascii?Q?LEHBsnuiPqlt7kXCUQNAKUAVKyKB5ruyDKxO+S0CjsFFQ/jITy44vifJUcVM?=
 =?us-ascii?Q?ys2Lqbvr7Q58DhrpkrgEChMC6smkRtmk+15uSNDsFukGoA15/bWcRW/KRwIh?=
 =?us-ascii?Q?uF9ro+ORnal6rHk9WCBQeyn9aOxrHnkfP0OhUEJWrBwzaZdbOCPFb8XMt31D?=
 =?us-ascii?Q?FdgBbn/o9PwZtugtN3rtX5YxZFj9NgoA3haiY3/iAPB6dhrCp7cFBfBKguua?=
 =?us-ascii?Q?eZuhT8R59+aIy8WYZkiFA3HTB+Ui7dWkBznW+Ty+9fSxErTnXCoVy4BFJcOe?=
 =?us-ascii?Q?+b9qOv/2vcfh2z2WUvakdPUc4TcGxYFUpT1yRh4icXbEIUYiY3tso/AqCg8s?=
 =?us-ascii?Q?24kEP6coum3/7akc7smh5lImMIcyNcL4XFT2jcSpxxKkHJcajK+cir/pgwqu?=
 =?us-ascii?Q?5l0aGeYHZ7PYGtVYHZVSB+f9WpGRYTYrc2Ui+Wbj+zDU3KTvZiivzQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I7Cnal308h4QrvCd9xORY9VBs53JVcnvozHfV8xajR3EM3Mw1/at/rtA2eJy?=
 =?us-ascii?Q?945OywTeZr6DK0hb8/WtzZuDS8fPQTixeLSjidJ3gqNZPSnMEKEyfzJIGbpv?=
 =?us-ascii?Q?iU/VCGjdGf4rSqYAG5vDo/WjgHTvQ9fhxQ07G4ZVBnzY4kgdoH66uYRyyDaW?=
 =?us-ascii?Q?ix2WC6RDeMMzF5OEOdzpG/MqIsrud/KvDKD6/Ke2OghdvFmIHxeqWtgHjhq7?=
 =?us-ascii?Q?KudbhnW99vk7ColiXBABpcyPc2+Ek9jvFzvPfh3EyL+ak0C2GCptKF1R3LBP?=
 =?us-ascii?Q?gtD9moerXQXO97KEMXBqNjwvNImFCtSywEsFKL7pt4p+SmkAY7Ocxr3Ledo6?=
 =?us-ascii?Q?CC8nYtK7oeADus91zTuX8k2MIuxAihJlCNjT754IEGeKOlOYZPgMMkUHPSE9?=
 =?us-ascii?Q?5p+CTxvLyYOtRT53y2rvSzTZ5egO5q+VA5qzsC/VrVAOYzRqD4IfLMQPTn6X?=
 =?us-ascii?Q?N6lLU9sqFMULHi5G9Nd8dL+Vfurpva3DRKJXi+Nb1dG40iH/Vyf6UxPu3bIQ?=
 =?us-ascii?Q?w/4q3lVUne5FvNbT/5bsWbkXajw3MRUmPZIKXSUvMT9ncxavTGXybcthHMwC?=
 =?us-ascii?Q?KrTW/achKNVEUeNdYCKU/kDYQ7h9xs5PzV2DreMkjz/DyALfEgfJj/RICuqh?=
 =?us-ascii?Q?xIhnTH0tcZNjR55E35LLBSB5loJlHg1hK/inhobsLxYAPxwSl1PEeZtOnxPW?=
 =?us-ascii?Q?LFkKNx9VnfqIx9MimHx8g7BhUWMTpK1ndnPWFwFZVlK6riaKUyjkvSEDy35K?=
 =?us-ascii?Q?YjXfLSTA4WEn/8JQUtoOkJNE/FQ9OfVaifbzALU391Sn57pia0a/e7UBBPhs?=
 =?us-ascii?Q?qQguj6eXjdPbyu6rnmS7/Hu6crTMi7CNNqMxp7DjRUEbEuy4v99kV3Zmete0?=
 =?us-ascii?Q?01mLs+fKyhCRfwvTm3MSugMyMayrdo3NYBCAf6+i8Ba55sSapX4IchnAWxNy?=
 =?us-ascii?Q?PcfLCkwE99rl3gH+eE5V5qgyK5DLh4jPAD1Npy7U/0gj5iHJHtjnqh2X1g3o?=
 =?us-ascii?Q?6YnPzEe+M3SDNiQ4lZqsovijSHYRS21MSkmwKFpEg8e4DSUxkvUXWJqcfTgo?=
 =?us-ascii?Q?1LnqPiVSSCJzph4BMTCXwcS1otDQbuFN/WeS3f8LG7iw832WhEWGvMePJoqQ?=
 =?us-ascii?Q?SaHlfIYVnhIYuwpboyRQjipAVdTt6olcmfrFc61Tx6fqEyPGlCourjL5Qvks?=
 =?us-ascii?Q?G74bBYyecpOAW9TMDa7PKAe/fEKbKai5gBNS65dfPGx+NM7ZIgt7iQWGfXzw?=
 =?us-ascii?Q?6iO0LdKoicyKXGMxHIWdupCRt5cgpa+HSLell0Gi8ksvm+aU7X3BCIzDI//m?=
 =?us-ascii?Q?rNET8tXpAfX4Ht1Rige7OWxfziQO21jJQAPrIaPhIOmhej2j0F3sMQ8IoXTE?=
 =?us-ascii?Q?EiRJt0T8o7oq0hMYwB1zriWoOv064Qu2SbOCISL5D8ljurlzhap+JJAph6/s?=
 =?us-ascii?Q?8/JSjQmB1LfCACIgDPdK6Gp8g1DJZVKNr+DoNbkhob5jLMSGcdNYcfQqPdgQ?=
 =?us-ascii?Q?DEKN9idKDzRcehKYnY17qoJ4Fhvuca3uNRwtJH7uq21yE0xAadHBwEMvUl+V?=
 =?us-ascii?Q?iauP2ZnHjMjvbPae3Y7Wo5+7SpJTl9rGJnQdOLHmxwh3Dd75RXTRJ3mdQHOQ?=
 =?us-ascii?Q?aQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 41fc669d-8572-41d1-cc2a-08dddb8806dd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 23:12:23.4965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mo9MFINLAdVG68guFsDMvpZKVesqALm1mKR3wodIJxuVyPFxHfu6cUsEHnMDx6QWBYI5hr9HsS8e7ynPs4M969BYosFWvUqVy95/QmTBHcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6032

Reading UBI on the flash with more than one plane per lun will lead to
the following error:

ubi0: default fastmap WL pool size: 50
ubi0: attaching mtd2
ubi0 error: ubi_add_to_av: two LEBs with same sequence number 403
eraseblock attaching information dump:
        ec       1
        pnum     538
        lnum     0
        scrub    0
        sqnum    403
Volume identifier header dump:
        magic     55424921
        version   1
        vol_type  1
        copy_flag 0
        compat    0
        vol_id    1
        lnum      0
        data_size 0
        used_ebs  0
        data_pad  0
        sqnum     403
        hdr_crc   c8418a31
Volume identifier header hexdump:
00000000: 55 42 49 21 01 01 00 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  UBI!............................
00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 93 00 00 00 00 00 00 00 00 00 00 00 00 c8 41 8a 31  .............................A.1
ubi0 error: ubi_attach_mtd_dev: failed to attach mtd2, error -22
UBI error: cannot attach mtd2
UBI error: cannot initialize UBI, error -22
UBI init error 22

looking to spi_mem_no_dirmap_read() code we'll see:

	static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
					      u64 offs, size_t len, void *buf)
	{
		struct spi_mem_op op = desc->info.op_tmpl;
		int ret;

// --- see here ---
		op.addr.val = desc->info.offset + offs;
//-----------------
		op.data.buf.in = buf;
		op.data.nbytes = len;
		ret = spi_mem_adjust_op_size(desc->mem, &op);
		if (ret)
		return ret;

		ret = spi_mem_exec_op(desc->mem, &op);
		if (ret)
			return ret;

		return op.data.nbytes;
	}

The similar happens for spi_mem_no_dirmap_write(). Thus spi read address should
take in the account the desc->info.offset.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 8e217ef00dd2..89bc09d3faf7 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -719,8 +719,9 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set read addr */
-	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL3, 0x0);
+	/* set read addr: zero page offset + descriptor read offset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL3,
+			   desc->info.offset);
 	if (err)
 		goto error_dma_unmap;
 
@@ -861,7 +862,9 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL2, 0x0);
+	/* set write addr: zero page offset + descriptor write offset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL2,
+			   desc->info.offset);
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.50.1


