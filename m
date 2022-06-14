Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3E554B007
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jun 2022 14:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356345AbiFNMJk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jun 2022 08:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240427AbiFNMJj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Jun 2022 08:09:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B89047AEE;
        Tue, 14 Jun 2022 05:09:39 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25EBYHCs014672;
        Tue, 14 Jun 2022 12:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=DKxt27ZwpJKTqEVwobRuvBWt32YA0yw5SPVvWF68aCI=;
 b=fgvnrVonDlp1hrHSLysxEBaxX+PF4z8xtwtG5tygI4COPAUyoISotugOULgC78oX/MN0
 tb8fcE5g45F5L7hkX7Tb8AL1NVoGYIEs/mUDJAnzBt2exsBQ16VftSzAQMX+RCUGz0CU
 6j7O/UCmI7t5N9U3lvCAM8jO8Orh55cHRtWCNCTXzCVK8JIHBnhXV8fk+fvNDfMLEHDl
 HsSHcnUz1n9rLun5dub3jrjsSLz8uKu9KcooNbuXB3t6VvvfuVxvai8DvpbsCJ7n82pc
 N030/SNDapYtUdhDuYuTcRuFLnghcprXqbCoq+YrZssp/ateYsYaExxOMCa/O9y1S2gc ag== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2nqs6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 12:09:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25EC5rq3038044;
        Tue, 14 Jun 2022 12:09:29 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr24k2uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 12:09:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajiLCGtIs2ex24qXTpfQMWkcu0wCJmbSiCP/QmkFiH0cpglpmlkFJXOICOYMkPmH9B5ujft3xcYRMbwCvWuT00d26pzUDx3PrFl/kmqskq//UyzUgjY1GqLYUdQJqL9sySv9vh4DwLt2tiZBnDrpCLfC2SuzsETYwM/Q3fSjUL3FW6YNzE6B2UpmR63gqyPCZKJMdzJsmrRmD651pX59iChv8OltDil/nFawzIE33T31akZXL8gZEbQK1/9l0yAoL9D/WwB9D1XOJu3qXHCOLcgNiD6gIqDLUDYA476fr5bJTATJX4QX39evHJl+paT0Hf3RPt8IBAeB7RX0q+xq7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKxt27ZwpJKTqEVwobRuvBWt32YA0yw5SPVvWF68aCI=;
 b=hBW0Kj/S+xQQyBMlCp+NY1JatzuhvSdp/1IMBm78EySBDe2bDz1QPP1L2a/mB8FocpSO3RcJZtb7N3hfXfPm3SQ6p/coyheFDk9Q4Gwg6S3dT83p5Ns757uRKDcU21l90cx7qvBWKD1QSDCeSChmJ9OqjeIVZ/fU2L8AfupAIrTdSRHTVrw5bTIVYatPXLPqvcfHGmgh1EqU+Ey3AQGWzJiNYOUJZ0pYcXkHwaa3kxHiuC+1BhsctckV2AHMYB2nXxQQ3HgU1ELlTuWk6OpW8CFbI6tW0Y3PYizc6UnMhN+qV3EiBPMnuH5deN6+0sFimWjeiOuKxU7HfLHzlyN0tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKxt27ZwpJKTqEVwobRuvBWt32YA0yw5SPVvWF68aCI=;
 b=LPxRzmkaVA3Os3pFbO8U8fBcBIsiVBPBhspiGqvBPNwBWLA+2JHfMV5zV7yS9Oj92vxYCYH8I9ShBLbMkxUrXjh3usD4Wei38PLQC+mYXV9LMFBKMBR7STq6HNkskLSJbMxbkhL8bRqkdhV6fNGhFkMZ4E5AsU2Tcg9K6R5QOjY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1482.namprd10.prod.outlook.com
 (2603:10b6:3:c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Tue, 14 Jun
 2022 12:09:28 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 12:09:28 +0000
Date:   Tue, 14 Jun 2022 15:09:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mark Brown <broonie@kernel.org>, David Jander <david@protonic.nl>
Cc:     linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] spi: core: Fix error code in spi_register_controller()
Message-ID: <Yqh6bdNYO2XNhPBa@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0140.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86b30acf-a519-4259-0617-08da4dfebadc
X-MS-TrafficTypeDiagnostic: DM5PR10MB1482:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1482CB4EF48A6F8B490D9AE08EAA9@DM5PR10MB1482.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RQ3DRn5GBT46JtI5/SmYj4Ji6PT3rIxxoK+L0ntsJLlB6X6D0ilZt3fzkHm95u9q8uEcy7XviKqv6QSNK1QpO5eCf8R/6JCbtUV8dlMcGzaVXFO8h6abYWYsKeJFox78LURFTqcZCQOkJLMMc8X0gYXdxPoV5EP5WmvgjX8uIdp+jTVk+Gbc14ZU2E4Qwpvebwvz1dzzVwjOa8Xcm++m90hO40iGgAw1ohbT6AxpnpcVE2vo3pKWbx+YbO0mdoTe3F7s7eFYx7H6bsTmhWasVD/2GviGXVkjtbd/5fowmfwk3EjSevrl+Fs9nIqcGIWgPFA3XcmiWK4AmMBk4CwGqKmqw8CMTqfFocLHqHIyhls00lzzok3k3/C8zPyaE/DFOkw5zcuYdBCarf8v5gC+Mv+PEsAubdT+qazqsc7F9NrVZ6pe1btqz+79APmWtm2UxYx2SgGJ7EzDY5kxGada/phfGnnF+u8sVSzq6XchUPeb3Zh0cI92Ks/uK1qQFVm5/xrjQ8NOZgOVuX1zgSg8WxZnfj2IW1mp3vXAsQP911lvvxUbKvrxOscS01zxZA6ZAqD3yBgL0RHe/89yn9JmLh47LAfwJVQjaVPIdycyhtJiQuK7bpk28FlxEHsMdlsM1MKmjpU9EphySnxrR8V1irSxtcjyC7jMZfvploOxEh4rZrsv1poQ03KgZ2gr3nbJIv9DRS1Vute6o9l/v05v1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(9686003)(6512007)(52116002)(6486002)(26005)(6506007)(6666004)(508600001)(33716001)(110136005)(38350700002)(38100700002)(186003)(86362001)(5660300002)(4744005)(2906002)(66946007)(66556008)(8936002)(66476007)(316002)(8676002)(44832011)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ZkYxYuZ+DHtynpKXqvec1SSqPp/ewhfTuPzna3X5nvFYmHn14omOdeR37Ow?=
 =?us-ascii?Q?6TGk6tbVZ1yL/dk6XOpiQIWJKdEXM+kEsJJ+AutS4BWdDIsi6xP7SryJW6t4?=
 =?us-ascii?Q?5kd9lB4wL3hVsV+chzHZdWzGILLyYH/hzsgDLZ0sIICVTgj8+IT/VoT/Eywx?=
 =?us-ascii?Q?sfbM357lLCW/hVwrZBrTjkVg/BS16cpqP4OwvrejTg+jyshRPwttgwgGLYwu?=
 =?us-ascii?Q?mCyZhv2pnW3G6BUjYOSHWkTk2FsZRdnvttnzDL9zpSBTmfE9QvkxSRwXnQau?=
 =?us-ascii?Q?T22kgnW5zYug8czOUDdgOdiE3F/vkb5nwl2ktAgTZR+MlNr8Kvm0nsGZRwhT?=
 =?us-ascii?Q?HYcpryYwP+pX/FRU3hmvdrhqm/2x0yG/CH0qZcmvNhLM668RoUnq6SSwK7Uo?=
 =?us-ascii?Q?d/NWTYRfakEV5FFKlag8mS7FV4jnUqYfThmfbt3M4BG/Y+V3FqQ0w7aRM0MT?=
 =?us-ascii?Q?85Bu7mLQhj415V0P68WQFqOl/iQGM9QKDWn86D1EGz9smAoddTJjnFTZQzww?=
 =?us-ascii?Q?yaOz4xNfVRGT3Q/vZmrUO7JqCkp23ynjY5HUpZa52J4Z47KnqQ1FSys5W5sO?=
 =?us-ascii?Q?SYeCVkrGd+kIhzKUzJPFybg8k9KW5L1aXmmzdAl2Hu1cevDZrcqsvwnkJH+3?=
 =?us-ascii?Q?pHd77y1LS1zNTPCLNDvI1ut6lpCftzORV7nO2jJNbNBFN7Ar4MbXdjVRp+wF?=
 =?us-ascii?Q?Ff9x4atQYx+uJnf5L4K+58mJEDhGsEMUJftnAbh8yGVKKBvMF6ckinzbJiop?=
 =?us-ascii?Q?FxBH1BqrDoee3/owJhhoK0P14C0KaZ+iLIUMCJ4el2pz8Ffw5OWaRnzjnMkO?=
 =?us-ascii?Q?pmRFli4F2VKxWP8nHQk40REKBdas793KzriO/VcRhlUvH0xQCrD22F7Qw+c5?=
 =?us-ascii?Q?hoRHl9kEogTWdDY9DS4reeRVv4AoV3QZmcBvgSREL0craqSqcUuhuIs1AIFG?=
 =?us-ascii?Q?Cstsz19VuoUxvxSsckfBRjUH9CieqaKrGzh7esx8SqykNE3TAGp5ksvnlTpa?=
 =?us-ascii?Q?C4iaFXAD7DmhpRvhAAYzwwLeJnHRrofeezyqK6iuhFMRMhBjAbs3au4DAA3d?=
 =?us-ascii?Q?4IFEq9grHQEhcKNUSNWfoJs2SrEd/NKKVclO8avpF/3gq/wgbQ1KJ3UDZHtK?=
 =?us-ascii?Q?jOlsecDthlWPvu4oOyKxPFQDPjHMRMLJHZH+xsxs3WX77bPJGU15EVyT9C80?=
 =?us-ascii?Q?3i0A6gUfwb4yKSI9Im050pkmw8d0rpeXi3R39oix2JeuzCZHrv0es8bBzTgK?=
 =?us-ascii?Q?vCftka6TbqtUZpCtuUMGVs0iJdFkXom8aJZqlvruSgIUKznoQmG+VC5naE4j?=
 =?us-ascii?Q?RRMqvtC01HJcvoVmGeDblCzvb95xv3KRkSPjpMmFG52EDxFIpznVkA+wBjJo?=
 =?us-ascii?Q?F+LYsC9e/A3Z8CvHgxpBtHZmpqpp4i6ktDqewyM8kc0WwZ1Dpz2Hrqug3Bkr?=
 =?us-ascii?Q?KzxrWZYH9EqlsDVYxzK+/6mRKMGI43CMsiXB9XLPzIz1Xpkz7wez05oDs53R?=
 =?us-ascii?Q?c7/kDRfCYhxvda29bw2QoylS/InEmBtBucr8zkqYwviGbPcPXqSCaedH2JTX?=
 =?us-ascii?Q?nR468cDLZAMTwCwiodBYl0reO6uXJyd4Cb+w3wO8bfVzkGRXSMWZEJL3ZOiY?=
 =?us-ascii?Q?eKv1jn5UTYUHpoQljcxr08kvw1+KANetVO7pFrWATwf7IPf+Q64Wkgt2E58c?=
 =?us-ascii?Q?jkJ4Z4nEqchTdghjLIj6GNI6VjmHO5w/q/+ENdkjgj9WMDeGNWsn1QtDas0o?=
 =?us-ascii?Q?zl/XtH4KKv51f661rW+t3T6YKNXubxQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b30acf-a519-4259-0617-08da4dfebadc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 12:09:27.9297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tj9JzoXHBRpSVFfP2m2Q9OrHNlb9b0daIrKg7t6my3MGiWPFBgUM7C9N/CtKtGtZWmxGwkHxdeD583fC/ZdMIXVU2UNgkK382+hDd9qoqKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1482
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_03:2022-06-13,2022-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206140049
X-Proofpoint-GUID: Di5jw7ubGf89QJAR4H4UikZwI6wWCURp
X-Proofpoint-ORIG-GUID: Di5jw7ubGf89QJAR4H4UikZwI6wWCURp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Return -ENOMEM if the allocation fails.  Don't return success.

Fixes: 6598b91b5ac3 ("spi: spi.c: Convert statistics to per-cpu u64_stats_t")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/spi/spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d94822bf3cec..85c552ba0725 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3079,6 +3079,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 	ctlr->pcpu_statistics = spi_alloc_pcpu_stats(dev);
 	if (!ctlr->pcpu_statistics) {
 		dev_err(dev, "Error allocating per-cpu statistics\n");
+		status = -ENOMEM;
 		goto destroy_queue;
 	}
 
-- 
2.35.1

