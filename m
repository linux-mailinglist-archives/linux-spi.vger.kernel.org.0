Return-Path: <linux-spi+bounces-7985-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67405AAE6D3
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 18:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6AA31BA4B8A
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 16:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5256028C5B8;
	Wed,  7 May 2025 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="sdhemY0G"
X-Original-To: linux-spi@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011025.outbound.protection.outlook.com [52.103.68.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C4828C2DA;
	Wed,  7 May 2025 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635493; cv=fail; b=O4R2YXTBP0GEzCtSosw7d7W+iQ4qCkazCTo6rBxO5RZSg7i39qMD7F7iQYl0UnOyoafezXx36cH4S/0NJ2VALTlJoEl8X4xyREvnbLkyd8+Cmawz48UXqevltK7UIkqBv4cTimW7ScuUT2eQYn/YGo4ngNjrQzHXfyCagJ1V6Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635493; c=relaxed/simple;
	bh=PJDJCTfx9nLtJDkGZRo7/XxclVU2pt9+ekoo9+5av0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=thgFBqIbOiKvNLDhAqRbBoYo75xhTMns3v1VdZVbi2zdO/ePYw7y2wq4O+nh0n1u1fnBOCG9f5g85rIwORq2ERDelejEBAV8DFogFsf9Z9poqWw8Y4gPu5VGvz8HqdTWOdY1UjZAiRLNhSUSJds1HkA/vpr/MsD/ZIQvgXHkZkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=sdhemY0G; arc=fail smtp.client-ip=52.103.68.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/7WPD/2SEUoqpbM3OwBFcq+K9z/LnCClMyWtZa/3KMcfFTNBbV70SDzuznLhyNblWJxDsbJS2MvlvV0YOoh8MoqWmq7eq4GPCaPHpT8VaPLNgZUbvRinnS7P9yxiF+nxZKuN6at8LOzj6m4TV+Y/nnOhgUKyWcpOUv2wXT9l2P+rKi/4Dm+eoJrdk4tdna9L9v4GXH2RyYNNCkyRyCxiVk35LONBeX18NfcMfw4zfLrFlJqrbVpND5869mdBHxxf/sLaN2pxQARA4tGKaMJZf8kpAbpD2M7iC3ryKs6Azo40AXHzHh4Qh8qcTcZF++85/Z2s4W7fwDoDa0A2z+dFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJDJCTfx9nLtJDkGZRo7/XxclVU2pt9+ekoo9+5av0o=;
 b=bCGwDYSJji9ZNvb6IVJzLafhffGGTBgp3fZTlNfomcJnRz/BPQlccP0nEtfE9hSg+wvg3NpsWNSRVKApOcc3YWNLIMWJL+k0jRK3KKTCXjWXCVA/6WwHZu9KBDtjoQAZoxf+6n8g+gvYy1ZVoYkA5qXrgecrp6N6+Lg5p2pV1YsIkeUWNdPiEX06RHBMoUfORaVJICLnhb97x2y84nGpXJPSdKHeEOXn3WbD4dR3CK/VvnUj1e38jKujSDi+l32f6wvM2net9195MdFp+qJGYTIqR9NTIkYyu9P61rDY2hJp7NRjenQWleUAiYexcnmPkF0MEZKZ8uZlGHRmgoPJEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJDJCTfx9nLtJDkGZRo7/XxclVU2pt9+ekoo9+5av0o=;
 b=sdhemY0GBx+ezCMuygp4W6k4itWjpJBG6MrjKjooWTYZjynD7AxKanKXh6kc3ICIdIBcBjNi+z3fHAwoH1mlVakA5uhLSHQLA9pzIADK9pVDc1AL21rQ3JxDZVViNgy2sl5VEDP4DRMQvLYbAWzmQoIxT06TpOh4hutq3tcCyPlRQ7pfjsqDrgwm8zgIhQ55QwK9p7guqFWx34FM6urQMtZo48hITNkfA6GUQaBN6Vjq3qz9z4zv8IN35kz+g1aQ2vZN8u2cxD2Vvch5rpIucON2yN4n9fgvuseAsxoRrxndijnCt3UW8RrS0cN2LbY6HJ3PC7EIM5ykwrCvavv9bw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNXPR01MB7041.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.22; Wed, 7 May
 2025 16:31:25 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.030; Wed, 7 May 2025
 16:31:25 +0000
From: Aditya Garg <gargaditya08@live.com>
To: joerg.berkel@bfh.ch
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-spi@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	lukas@wunner.de
Subject: Re: [REGRESSION] applespi from 6.12 onwards
Date: Wed,  7 May 2025 16:31:03 +0000
Message-ID:
 <PN3PR01MB9597CA6E163DA8D0F358F7AEB888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <4dada48a-c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch>
References: <4dada48a-c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PEPF000001B4.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::6) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250507163106.3225-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PNXPR01MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f974fc-d476-4239-e4e6-08dd8d849bfc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|19110799006|15080799009|8060799009|7092599006|461199028|4302099013|3412199025|440099028|34005399003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjEwaWxxSURlbDEzY2p6R0l6SnQwbldMeHhBQTBiKzJRVHE3bmFUdm9oRWJE?=
 =?utf-8?B?am9nZ1B1T20vVkFhMVRDRlNGbEwwd1FlYU9vRUZVbnJTaDVsQUJjb3lCQkNE?=
 =?utf-8?B?VDZuRlA5OGVXWlo2NjBqZzNRMmpkMDFEN0JEOENrK1JkbmhPMXhDeWRTY3Bk?=
 =?utf-8?B?OFptTnhSYUxsWnFweHdoRjhBbjlKeDhCUm1XMzNzMlJNVExKWUxKbm5leFBL?=
 =?utf-8?B?bTVka2NjVUxvWHBONm5CZEwrWUR1TlRRSlJpNG50Z2c5M1RPOUJGc0NUTm1T?=
 =?utf-8?B?VGJEekRtOFJZT1k0TUdYR05BdktrQlNieW0ySEM5Q1liUHdFeU1tZVdEQS93?=
 =?utf-8?B?cWkrZ2ZLMWhydm50czFHZHFGSEdUeFFLV2NoOFR6M0I4TVNhbk1rM2tvQ21D?=
 =?utf-8?B?bUU1WjNxdEowYnVwc2s1OHMxTFVmS0VvU2NwYSsrZEk4Sm1DSzhIM1lTRlhj?=
 =?utf-8?B?Z0hsSEU2aW95Y0xZcFlqK21VVVIwNmxpVlRCSXFrUHB0cXA2dkFSLzdwNlRG?=
 =?utf-8?B?dGlkUzZxL1pWUGJRNjVKVVRPNm5LbmtQRkZMSUFzNGg2ZndCWDF1RVViQ2Zu?=
 =?utf-8?B?SkY3ZW1YUE0zUExaYUd6OGVDZEdheTNYc2tBc1ZvV0ZjWW5SS2JQMUt4K3Ar?=
 =?utf-8?B?K2laU1BOYVdrT0llenc1TmlhM1JKLzZQVDhQYm1QWHRLMWdQRkVYM3k3WFU1?=
 =?utf-8?B?aG9vcW95eENSOHhJc0FaZUdYb3kzNG9RbmJid2dyVllOUUEzUEN0bEdOZDIv?=
 =?utf-8?B?Z0E2a1czWldJQ0RERkF5RGtDMmdUQ2FtRUVXTlhpeHZTUlBPQ3NGcGd4V2t2?=
 =?utf-8?B?NXJsZkN3VUQramZMeksxT2h6OGEwRlRtdWY1N0pmYWNoQ0Nya0YwZnYyMk0x?=
 =?utf-8?B?cXJYaSt5VHh1RXBjSGc1TTJYTnNneHFZUDlNaENqK0lRMit3V1JVY3d4SmZt?=
 =?utf-8?B?cUZQbkFpcitlelluQ0pIWFpZRUMrSDI1NlBuZExiTWI0SFpXcXNWVDhmYU9t?=
 =?utf-8?B?Um84c0hPNjY2cTk2N09pQm85VTFTaUdFaTQ4SEprV0kwT3BxTmZ6SEVBNXN1?=
 =?utf-8?B?Q2k0cWZkbFdIbnQrMTJGNGdUV3YrSlQ2dm81cmlxMUw5OU52SlFTNXkxZER2?=
 =?utf-8?B?VWM5RUVRS2JVT1J0a1BGc0hqYVdzWW02dHlzM1RQaFlCdW14UE1XeTN1MXFp?=
 =?utf-8?B?NUZUdEVjblNzWXZSWkN5WFQ0S25kVFRjTXJuSG9QRkNtaFhGQ1BELzVHNU9k?=
 =?utf-8?B?T2F3NE91cFltelN6ZTdqSGN6YmgvUWtvVXRuVU41T3N5aXpsNWxWMG9ZVWVn?=
 =?utf-8?B?aXNSWW1tMCs1SnpScWtaT0I1NU5RMk5oN3JvbnIrbktqU2laMXVyOXF2LzR4?=
 =?utf-8?B?SDIwRTRyRmpvVmQwS0ZIa0JSbXJiSU9vcHZzQWk2N3BjMVN6NzBoYmdUNkxy?=
 =?utf-8?B?VkIzZjMzYlFjdUc2TW9hc3VIcVhQWGxnQmJuOEMzQUtzM2ZXN0crL21GS1di?=
 =?utf-8?B?OGJMSmdPQ3A0aldQTk5kWGVpVmN1MGdsZE5ieVVuRndKZHgybXBkckZDV2Jm?=
 =?utf-8?B?RjZWSzh6b2tOR0JFY2EyV0o5YkpCMFpZTW42TFpkalpyUVN0RnQ5TVVaUHZN?=
 =?utf-8?B?bEpXN1p6OFh5Mk5uSUdmeVc3bkE4YU51UnB3N0xDd3M3NlA0bG8vem04L2Va?=
 =?utf-8?B?K0lzRWdsRjF4TXpFMlQwVkczSm1YRU51UFVvam12VzBhcDkvMzEwVWUzenh3?=
 =?utf-8?Q?aae+HaD6EJONYVO5Dk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0dIRXNpYzdBVm4wcjl4dC9ZY1YxbVZvL24yT25MdUdmUHMxbjk2bVV1cDBq?=
 =?utf-8?B?L1FmcWxabUlZQnNZVVVjUVhTN2NiNzl6Mjd2SUk4NHN3aGpueU1YQ0xKdHgx?=
 =?utf-8?B?N2xLanlsNzBxQTFQWmZBWml4cVRXOHNNallHQXlBMEJDRU14dDZCTWFYTVEv?=
 =?utf-8?B?ZUV3c1N2VmNCZ3dZK015N0szR3NHdDZJYUhPVWRNaksyL25kOER3c2pmblVO?=
 =?utf-8?B?NFp6bzJsR0d0dmJrMTFiTDVjT1RqMG5XSWJaaXhYNFRyOCtkd3ludEM0YlNY?=
 =?utf-8?B?RHgzeUJyNnZsS2txMk82QitOWUl2Z3JiTHVsbVBnRUtxRnd6azBjR3pWWG9S?=
 =?utf-8?B?Z0lTQmR3ekRvWTJ1ZEJaNUR2YlU3Z1RGYk9xNk5DODkxMktqclgzSlE5SzA3?=
 =?utf-8?B?dldiQWlaZ0dhSlZJRVpZakRML0JaT1FJVDVNTE9EcjUxYmMvNnhpK1hrSjJh?=
 =?utf-8?B?WlBLelRidmFTY2ZMbmUwa3lwdTFYRWRUQkNUOEY2K240dFFPNnRmQXBoNXVv?=
 =?utf-8?B?MUZEUmlBdk42SGIrVml6NTkyZ3FMMFUxM1BwNUpMOWhrZDZRY0JDbGN4a1ZT?=
 =?utf-8?B?cEFsdEloY01sUGtrSzlDczhveGM3SEovc05iYklPcFZZSk1vZ2xHdDV0cXN3?=
 =?utf-8?B?RUE0M0pSR0JGQnFyamlqbEljZ0lEdFJQWmxYNUNYMmJudDEvQlo5U3VXY0g4?=
 =?utf-8?B?cnloTUZiLzNYRSsyZmRQRERmSTBxWkVUM202T0hyWFo5eVpoM1UrU241V29q?=
 =?utf-8?B?b3NmU25vQ2RXZ0dyT0o4REhNZUNKUnpYLzFDczZhYklYRkFvb1hudVV5MHBi?=
 =?utf-8?B?Wk5ZR3pxc1pxZm1IdVgwU05id3AwMmJpOXVQMTZ3blRlL1Q5MDJvWVhVTDNY?=
 =?utf-8?B?SGllTXlLY2RQVVpoUXR3cU1lUUQxZm1UbmRkRTAzTXk5U1V2ZENWUFFMRk04?=
 =?utf-8?B?WmpjbUJzVVZydzNkTEVQb0pibURYTWF4djJFZXhXcW84YzJvZDh3QkRRWWNQ?=
 =?utf-8?B?NzNGdFlnQnVLa0R2RXhtUnBlZEVhZVRtMWtWU1dsTXdadGt5emRBcUR5STFI?=
 =?utf-8?B?ZW1tRlZUclFqZ3pVcHd6R1hhTEMwNnk2RS80ZWFmYXl3NGRyM09NMHpJd3lB?=
 =?utf-8?B?OE9RcDBJM05VUDUxbHpWS3h3dk5DWEJmTjNPeWhDK042SXpqY2hKMVgrRXZm?=
 =?utf-8?B?ei90dWYzUjhxakEzQlJoSmt3SXd1T2VJRndUdXdHUVZtMzcweURVMC96OFda?=
 =?utf-8?B?OHQycTZhV25DZGRhSW1IcERoTkhCMHMwOHBkL08zVEQzL2l6Z3ZNMDF1N01h?=
 =?utf-8?B?blo0ak96MVp2Vit6MTRDckRJTjF3S3kyd3JrSkxIeE9aaW4wUXd1R2VnTDJa?=
 =?utf-8?B?Qk9zNUM1YmFVM3UxWmplR1FPKzhURmFXMU9DcGNmNU1YVXBFdG5mTER2SFZY?=
 =?utf-8?B?VGo5SldmSFk0cThwUnFrUXBhY1pEb2t6NjhZREU3cnVWQ1IzRXZPSjVRaTJS?=
 =?utf-8?B?TTBaM3hpWjk5azVITXVkaldqNi9NRVczSlp1N0MxbFNPOHdRcjJwaHcwMngy?=
 =?utf-8?B?OXBoMzI1QXdBbVZwdi9xQTNINU5YNUFrU2RuMDh2alJFZjFwa0ZUNWJuZXc5?=
 =?utf-8?Q?FEMCSBX/4oxsLsNpwZoDdGky4oHOT6S0UR2A4bktJ5hY=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f974fc-d476-4239-e4e6-08dd8d849bfc
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 16:31:25.1702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7041

Hi Jörg

Did you try bisecting the faulty commit? Is is starting from 6.12 or some
version above it?

You can also try testing pre-compiled kernels from here:

https://kernel.ubuntu.com/mainline/

or here:

https://github.com/t2linux/T2-Debian-and-Ubuntu-Kernel/releases

