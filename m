Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653F650066B
	for <lists+linux-spi@lfdr.de>; Thu, 14 Apr 2022 08:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbiDNGwa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Apr 2022 02:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiDNGw3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Apr 2022 02:52:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AA53FDA8
        for <linux-spi@vger.kernel.org>; Wed, 13 Apr 2022 23:50:02 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23E0LGlB031973;
        Thu, 14 Apr 2022 06:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ktl4/OjrQo4N7St3otjWs9OTlFEuxG/fsfBEoTz0O6Q=;
 b=t6KW/y1i+YnKdUQsQ5CxiB+AsSJ32YIs2UPJmYiuGgtwN3kYK3WJ41894ENcSYy6+cl/
 MAsSlemq8XOsljrm2dvy3dfo1T35veS95mivVuw2n6YvcRB40XN2NU8lDd9/W6QG75zi
 lEBq7S+bvnVpQIDEqqRYVQPzvC2K/AsZAG7C9qDu2QvbWFIm7t7uNhz2zJi9m1527hve
 TG75/N5eaRQBSQXGQrFZtd+Ab3SyUw/D3uDAzyU95pMgjqfbssO9HTF+sZyGPIu4SXh6
 nTwy4m5KqrPzpgRq6ptlIKDnpwEe7HEuoSdjxTONoP+SAHkFlDIjzopHnZ+qDZYtRp8J 0g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jdbk10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 06:50:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23E6fOcH024260;
        Thu, 14 Apr 2022 06:49:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k4g3jb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 06:49:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYw+bM3MGDL4ApOpQnotQf8hA1ZsiO/+kK3+cKhBJnyA4F9dwtYYwTnB9eHjYQBrmCvgLZ77XRgRVHPS59c9/oaDKIM7XxUcLKPOibsgU/WOT/RrmZebbSDUQRHcM8KLmbmUDlklkFIlF0fXGQSAkP7E8xz9iNi+s7ntMsdIAKe8dwlZH0Q+jbWUX5SXZU1erFxSxnQ8ddx8QsLG5FFEoZzZWzxoOJ1vkX64Nt50d94etGUUWDoJLSTAzG1a+cyCkbDUZ31ebowdcmMz0cuP/hqz9+nAUIH4pb4ohqqHP9bQ24z7/7GAps7oG1tC3qBiVb3o91xXNxycAVMmaH7WnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktl4/OjrQo4N7St3otjWs9OTlFEuxG/fsfBEoTz0O6Q=;
 b=lX0nyc5Zpn5tblF3vWCIslkq4PyTj+UMECe6XuoeP6NoHGE9p5V78titAQoZnX4dyRd2ZMoFj+ob6av3brkoQZ7p9jni5ASDA+aQNkDMMTFn88ORJ+ShgPjPetLuZ3s75yFcDcSmtMy+hPPLATBvmLRNBXGMH/Q8zG/sb7OQkrAJVnAfm3v9ud9q+gpUhUvsQxIJDrd51JtwFFVUoVClmFiJInfspfSkUJ+gMvHoFZ2NV4/h1UN6JuVmvfRe43b+6OweCrhGXhi+8okJymgQ3q0Glv5erv9UNEci7I6zpyjZ5CaSU2ERuXKcIqNJJTdT0YENw2X7mfXdzcUKfVJOTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktl4/OjrQo4N7St3otjWs9OTlFEuxG/fsfBEoTz0O6Q=;
 b=p73QCn5Zb5VyOe8lIbZ77Eb/bsRSBf5rSJ1mpyjMdlX8TS+0xihPCxguxVzw4AC7x994N0R9eyukXlLo4pFxmzepf9H3LGwaNVh+d4nBoVL33CLC9Hm4Z+tG78WzV/z6v59NOHWlxyki7iD3ldDvpc6zbOpQhxCDqijMRwYtaew=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB3728.namprd10.prod.outlook.com
 (2603:10b6:208:115::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 06:49:58 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Thu, 14 Apr 2022
 06:49:58 +0000
Date:   Thu, 14 Apr 2022 09:49:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     paul.kocialkowski@bootlin.com
Cc:     linux-spi@vger.kernel.org
Subject: [bug report] spi: core: Only check bits_per_word validity when
 explicitly provided
Message-ID: <20220414064948.GA9873@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0043.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d113205a-7c73-46c9-2e22-08da1de2fd69
X-MS-TrafficTypeDiagnostic: MN2PR10MB3728:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB372835CA51488CFB6EBDCC1F8EEF9@MN2PR10MB3728.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +1Y7umyoRe2Qogbi+BvX0zO/ZHIXd0oTOVWyPorGYdHiUSHFBFKLAuNXuoGiDa7OU8MWNjKoNC7p+I2ERgwRFxtzUp72n1dqGFZDW/4OSq88bKGB0COB/wybU6PsvwySOFAGA0JsZmbRI6V/VEnYsuNIAFiUkLMNqwToJ7JH/vDHDi0LV5pLDwWP+CF9nW6DWRDYEIuB7rfBFYydenAmYwlSSVczmyHEo7ssuqQjV7XPcpru+7eUOdk+wHTs/Kf7gfS2lsUJbT1soPIl8VZ1auAwTLcvA7//X9x2pkK6deM/50dtOn/bonl1e9Jmt7FihDHah/FJNoas1muaJtjOp4qyTK0S4OA3kq6SzybgNifRlmly4DlEr7xCrVLXvyT0723u17yRW2YQU8pMPoMDulGS//Uv3xNolspp2q83WGSGxuCuSeJH1DK2xJKUF/WqMVSTrxL0KSu0SejXn7M1tVbVjd0gKJNcCkLFXZ8us+1KcXyYloFcA47goZAgeb1OTd04vMs4fFUg7fP/krsK1z2ULjBA24FKdlHkiV0//gpD3X11n12tpGlEl9BKllhV9SB/zVGP1snuIykYWTJyaTtE1knbe4dHHtbiHtWYhn+RnQufWsiXv3/YhJsh0IkSV0aZuR5NQ7ox5G7LJ1vYVyGPMvvUGzgxgf9dyxv1YYnQ80JYP7jbxuSSBbGQ8PY48ZR4N2THT2PNBXoF5fIe0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(86362001)(66946007)(66556008)(66476007)(44832011)(33656002)(83380400001)(6666004)(52116002)(38100700002)(316002)(38350700002)(9686003)(6512007)(6506007)(6916009)(4326008)(1076003)(8676002)(8936002)(2906002)(33716001)(26005)(5660300002)(186003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZlAtnI22vnS0U3r75fL0AP1CdCG6p1vDTHri8MqCt+dQs8lKx4L+OX86WyT9?=
 =?us-ascii?Q?L95+Hf80N4KNf7zAqZMcVXVLLduumXarEzAKAkLTGEpvPVTOh49E2HNLYmGM?=
 =?us-ascii?Q?kBT81WGH0xNkl+GS0+OLCuEqQDTzOSxuvL53bL+CbkDUIJiKEs39Lz/XJUSd?=
 =?us-ascii?Q?YfLd9oxr79lW2h+9AcysHO+H3g/70HShsnZGScvxYpEkKT8KK+P70u9WlrSd?=
 =?us-ascii?Q?CDkQPXLFW8gjF9zSU5wGgPKISd9PbgYRuv1EGhIvAvuhwpMmRkk5naFJKnFD?=
 =?us-ascii?Q?Qsm52oGtwQpdTYAC1AkeCecglPIb8xZmgz4aDBf3AFVeIMSkB5tl2NEyvs3T?=
 =?us-ascii?Q?Fh2zg/DbMQZs6AWbGcV3Xba9zKIRCa7DjcYE6EBwVox0Yinj6HjBiva44o04?=
 =?us-ascii?Q?lt0q6C019AT7NkY/8Thfn2b4K4jwtnsNMMhhMMJyIlN0OGHFaTeGbm9bObrw?=
 =?us-ascii?Q?TP4ntdl5PXNIpA6e2zSCT/yxMk5Valac2vVhpvI+4N8iNBhIsA2u9JjIZDJi?=
 =?us-ascii?Q?2J4t7vt6mf109wIzmvo9VPnB25ItaElDPDBgpeo3OQw9f+SjQs9PEJooXLEZ?=
 =?us-ascii?Q?II4SPPK8gT/cX9OPiYBRIO8+PcTYgOhy0KqXe45T5J9p8lp+rmz5QY59B6zU?=
 =?us-ascii?Q?3jjUBPtcgIYjTUW2M5DVdZ+gGk3T49SKVlUV/btlry3fy75gfONr2q8VxG+O?=
 =?us-ascii?Q?gHVMT8eHjQcYSBGDp9y2nyoxoFeNh058na8YZm53p5I1UaUEUq3EX6a+Kc1A?=
 =?us-ascii?Q?+pEopBKVsQRVG4KfAb7VDCcoAP9rk/DDN+HKHRNzpwh5ADJKtLrbgDWAta/r?=
 =?us-ascii?Q?Km/CdEEZotCGOir0XeQQv33N2/8zXSGHpTxDEYpmFePYOAWDq9E4ql53r4ys?=
 =?us-ascii?Q?WF7Tr2daYNY/Qw4tdmjG3Mm8qYdG454lDfE37Xyal372sVJIAdIUNX4g0tGj?=
 =?us-ascii?Q?dDsB/stXdJbvt3BTGsCXuugC2J8pCQtDL3KojtLyNtVHjKCuo1gn6VpX/Q4k?=
 =?us-ascii?Q?L1j3NF6Bd8hJ7LaSriVkCcLWIqNf4F0+ZK+cAZyN/LQ1Xw2e9nBkdczOxjJU?=
 =?us-ascii?Q?U8XZdYVMP5YGstIuz1hG6/drNXE9jvSC0IiD1Yzr7N7/uMwHLdrR8TIiiDfB?=
 =?us-ascii?Q?wKD5rVfwzDQD3+pTuFvhOV2jXqXEhRHWU7nZkoqiwyqQNiZbdKrj62PcxGBt?=
 =?us-ascii?Q?dHis5XS6PDtGPAr+5h13tiQ6jhWwiIixsns24p0WCeOLEsJJ+CGK1w1/INWe?=
 =?us-ascii?Q?/qzOotrgc0kurIQV3YMVWWaPuzKFqanrqxPjNXwz861ilG3M3IzJ7346oAia?=
 =?us-ascii?Q?z5iatrzregynB+1oGuUfJSwP85HOobXDSNk0fN3KUXE/sWIr44h8sraYE5yN?=
 =?us-ascii?Q?eb9pQNqsVoxaALps3V7gHgXp1h+IlvMMkPOYTRJmsDS9XJJ4R8uNk9jGSb/D?=
 =?us-ascii?Q?x9zR2ysMwcSYZaYj7dvMucKbQIKOnMLArNsMF6V1Z2NHHPvWTHhTZVyH2BD0?=
 =?us-ascii?Q?FGmCmP9gXu6VmBGy1zfRChggQ4BoiAJXdsUj8C4iq4Np4gpaZRn4Yt6XOapB?=
 =?us-ascii?Q?DtytvU8bE5Je1HK2uhJlAN4JRtoAh0WhhqtEZq+F/W1u7dzeu1kHhg6To8WK?=
 =?us-ascii?Q?uMZBGxUio43kRLfkWiEVEwK4OtX27ExdIapUn03cIJP7wqijHGb6pIw1Zuud?=
 =?us-ascii?Q?0XJbZevUUG1Qg71xfvaLOVSuiJ6sG6CYagZUhtgSmoiGpXNpX96fz+x5mZcO?=
 =?us-ascii?Q?u9wu+9HVxXbM/l0SkvNvgaats2O+0XI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d113205a-7c73-46c9-2e22-08da1de2fd69
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 06:49:57.9408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWjubUWTHQwQROkj5cY+bcI3T0oFWy9okEMaClCz7/EfRr2MB2LYSBMTR65USDv75N0ZOj3Gfl+rkwcELhygV0J+UaY/3Kqr8kLWlKELRbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3728
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_01:2022-04-13,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140037
X-Proofpoint-ORIG-GUID: LRmsYT1ZnJjZgxfUfD5LU5cJVvFWnKcm
X-Proofpoint-GUID: LRmsYT1ZnJjZgxfUfD5LU5cJVvFWnKcm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Paul Kocialkowski,

The patch b3fe2e516741: "spi: core: Only check bits_per_word validity
when explicitly provided" from Apr 12, 2022, leads to the following
Smatch static checker warning:

	drivers/spi/spi.c:3583 spi_setup()
	error: uninitialized symbol 'status'.

drivers/spi/spi.c
  3475        int spi_setup(struct spi_device *spi)
  3476        {
  3477                unsigned        bad_bits, ugly_bits;
  3478                int                status;
  3479
  3480                /*
  3481                 * Check mode to prevent that any two of DUAL, QUAD and NO_MOSI/MISO
  3482                 * are set at the same time.
  3483                 */
  3484                if ((hweight_long(spi->mode &
  3485                        (SPI_TX_DUAL | SPI_TX_QUAD | SPI_NO_TX)) > 1) ||
  3486                    (hweight_long(spi->mode &
  3487                        (SPI_RX_DUAL | SPI_RX_QUAD | SPI_NO_RX)) > 1)) {
  3488                        dev_err(&spi->dev,
  3489                        "setup: can not select any two of dual, quad and no-rx/tx at the same time\n");
  3490                        return -EINVAL;
  3491                }
  3492                /* If it is SPI_3WIRE mode, DUAL and QUAD should be forbidden */
  3493                if ((spi->mode & SPI_3WIRE) && (spi->mode &
  3494                        (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
  3495                         SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL)))
  3496                        return -EINVAL;
  3497                /*
  3498                 * Help drivers fail *cleanly* when they need options
  3499                 * that aren't supported with their current controller.
  3500                 * SPI_CS_WORD has a fallback software implementation,
  3501                 * so it is ignored here.
  3502                 */
  3503                bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD |
  3504                                         SPI_NO_TX | SPI_NO_RX);
  3505                ugly_bits = bad_bits &
  3506                            (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
  3507                             SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL);
  3508                if (ugly_bits) {
  3509                        dev_warn(&spi->dev,
  3510                                 "setup: ignoring unsupported mode bits %x\n",
  3511                                 ugly_bits);
  3512                        spi->mode &= ~ugly_bits;
  3513                        bad_bits &= ~ugly_bits;
  3514                }
  3515                if (bad_bits) {
  3516                        dev_err(&spi->dev, "setup: unsupported mode bits %x\n",
  3517                                bad_bits);
  3518                        return -EINVAL;
  3519                }
  3520
  3521                if (!spi->bits_per_word) {
  3522                        spi->bits_per_word = 8;

"status" used to be set here, for sure.  You would have to be pretty
unlucky to get through this function without setting status at all.

  3523                } else {
  3524                        /*
  3525                         * Some controllers may not support the default 8 bits-per-word
  3526                         * so only perform the check when this is explicitly provided.
  3527                         */
  3528                        status = __spi_validate_bits_per_word(spi->controller,
  3529                                                              spi->bits_per_word);
  3530                        if (status)
  3531                                return status;
  3532                }
  3533
  3534                if (spi->controller->max_speed_hz &&
  3535                    (!spi->max_speed_hz ||
  3536                     spi->max_speed_hz > spi->controller->max_speed_hz))
  3537                        spi->max_speed_hz = spi->controller->max_speed_hz;
  3538
  3539                mutex_lock(&spi->controller->io_mutex);
  3540
  3541                if (spi->controller->setup) {
  3542                        status = spi->controller->setup(spi);
  3543                        if (status) {
  3544                                mutex_unlock(&spi->controller->io_mutex);
  3545                                dev_err(&spi->controller->dev, "Failed to setup device: %d\n",
  3546                                        status);
  3547                                return status;
  3548                        }
  3549                }
  3550
  3551                if (spi->controller->auto_runtime_pm && spi->controller->set_cs) {
  3552                        status = pm_runtime_get_sync(spi->controller->dev.parent);
  3553                        if (status < 0) {
  3554                                mutex_unlock(&spi->controller->io_mutex);
  3555                                pm_runtime_put_noidle(spi->controller->dev.parent);
  3556                                dev_err(&spi->controller->dev, "Failed to power device: %d\n",
  3557                                        status);
  3558                                return status;
  3559                        }
  3560
  3561                        /*
  3562                         * We do not want to return positive value from pm_runtime_get,
  3563                         * there are many instances of devices calling spi_setup() and
  3564                         * checking for a non-zero return value instead of a negative
  3565                         * return value.
  3566                         */
  3567                        status = 0;
  3568
  3569                        spi_set_cs(spi, false, true);
  3570                        pm_runtime_mark_last_busy(spi->controller->dev.parent);
  3571                        pm_runtime_put_autosuspend(spi->controller->dev.parent);
  3572                } else {
  3573                        spi_set_cs(spi, false, true);
  3574                }
  3575
  3576                mutex_unlock(&spi->controller->io_mutex);
  3577
  3578                if (spi->rt && !spi->controller->rt) {
  3579                        spi->controller->rt = true;
  3580                        spi_set_thread_rt(spi->controller);
  3581                }
  3582
  3583                trace_spi_setup(spi, status);
  3584
  3585                dev_dbg(&spi->dev, "setup mode %lu, %s%s%s%s%u bits/w, %u Hz max --> %d\n",
  3586                                spi->mode & SPI_MODE_X_MASK,
  3587                                (spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
  3588                                (spi->mode & SPI_LSB_FIRST) ? "lsb, " : "",
  3589                                (spi->mode & SPI_3WIRE) ? "3wire, " : "",
  3590                                (spi->mode & SPI_LOOP) ? "loopback, " : "",
  3591                                spi->bits_per_word, spi->max_speed_hz,
  3592                                status);
  3593
  3594                return status;
  3595        }

regards,
dan carpenter
