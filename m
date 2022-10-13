Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1DE5FD89D
	for <lists+linux-spi@lfdr.de>; Thu, 13 Oct 2022 13:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJMLpU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 13 Oct 2022 07:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJMLpS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 13 Oct 2022 07:45:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D246765568
        for <linux-spi@vger.kernel.org>; Thu, 13 Oct 2022 04:45:13 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DA3URx010256;
        Thu, 13 Oct 2022 11:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=aVbLvMV3nI5Nks06G2HAagtqU7zv6V5u9yzuqmpU8O8=;
 b=jP73DtPIwCiOuYHuoEo1iWUOoPArcGGtSKrFGOC49m0fF/6crg4U5z71yzWU3YaQmX/w
 Vpl69YoykqZH5n77mvbaF+3XN2EZkjOtv93CMOVhiR99q1xNKHsSh0RWTPqGeP3IgqJA
 U4CNGw+AG9/r1CZiQKEaIVryxuhpI0zY/pJZLeTVYS1rO3UOntrSh7/Ekl8pY2sD7q24
 OmBTfYc4RamYdVpq0DOgpHreaI81bcptryFJL7nRDwKBYGY7rF2eTJFl8O2Oh7MgEZGh
 EPL+D3/WYIG6I3wu2ZeTNnpBymyJIIIe33yEc6kuR2E20mewxfEiNgWTeWbYQCP2FWr4 6Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k30034thf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2022 11:45:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29D9062W019414;
        Thu, 13 Oct 2022 11:45:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2ynce9dx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2022 11:45:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaBs0gNcay2NYNfJa7FIzZpm/PHZTPH/xMGSH6ZgqROS47EFxjb3n54nkAlkbUcQ6EwqICtiRzteZxR574gPOBXvcnYK251NDjZrTIEbyXJM+93Kpf0dMvm3+mONX0tuopeCDVQg2zR3SpU+VLc01SUHyIE4aLAT/1I0ZE2i0S8U8zGN+F70MTvmFvqwrNOBZFCL3TLooq7R4ndZQEUb895wkFtAjyiNvkChJ9f7CL5vrHYigDqgIqRyfUMwnW1KRR2wm2FjXtuS1PdAioykXZa2qFt7NyQ/D63TP4KyTBuFfrmHo27w1aE7EUtlw7jhOdofKZmar7d34Ro3k32Z0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVbLvMV3nI5Nks06G2HAagtqU7zv6V5u9yzuqmpU8O8=;
 b=eN2ierCdCHXBqOaqYHQ3ZK7WJ4bE0+3h3CjB99UFEolJp+YQuXzbu4NmlA0Av+yr9oj0LAuY9r5K83u/AXMk3BbvviLqbaA7jr7WGmFjPTnTHEym7vRkmojDPAEOdqHfmWUhqPQ/SExM+QxTU70ffZ8MOrbQwdNCZHoovUVmDokb+jzTlJS4awMA2L7H/GIy+jv2tWKniG/p30UIc5APvVd/cnLqZaUjm9B8idUf8GhBK3LcURxkQ6i5uva7YLmCkDvAOxX6K6k440Sl0xEyOmTPwGSqnhDi0bQoScRkgqAhWsI2fuvhXYCwUnRnPy1s3q86fZl6hoNZmh4W4W0VsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVbLvMV3nI5Nks06G2HAagtqU7zv6V5u9yzuqmpU8O8=;
 b=RqTSuLe05BiQSWTWsmapIBfjoH7dQOlz1U5AGiXRcr+gC5qIc4tsFZderNlW7mAXVHBg9YbRgMec+e46koHHsFZPO6dXUof3rShXujNsBn2MJazzqCiiZZNBV69Y+r8L8B0k99x/Fawm59xNyS5Fi7fZHbFuA66q5HwaHfVcWGw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY5PR10MB6168.namprd10.prod.outlook.com
 (2603:10b6:930:30::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Thu, 13 Oct
 2022 11:45:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Thu, 13 Oct 2022
 11:45:09 +0000
Date:   Thu, 13 Oct 2022 14:44:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kyarlagadda@nvidia.com
Cc:     linux-spi@vger.kernel.org
Subject: [bug report] spi: tegra210-quad: Fix combined sequence
Message-ID: <Y0f6OwNdG/x/kskT@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0148.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CY5PR10MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8fbd48-ce96-49c6-e427-08daad106132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KX1pvhTD3QlaLu0TzGlNQARac8osEyCew5GmWt+Lg3Ad1piqVNtqZkpfK4xiL+BWjRwK0aJQd58mtjL+90/X919CDc2PLTIBMfyms0tkisBKq49N/dZqa4C1Y7F3un3hWzys3nqgv5nxy5Nmo9C9ogrmMEssT/Dev7E3VBFnKx6CCUV78VfBI4g95vEPtzGzxFe1X/keh2cMyMyUZd/dqWM3F7bPLyiyO5+dL0+sJTbXPayB/+aKDuFPMKuXrVfx6x01TDxyWwA02Li5lt3yWBbvPOFkHvP94y5KvFlGsZSKVcbP79/CkSwExnmSTH5B8N/ePSX41hBNiWh34Si70o0kGxlHWlPALAI7SxQVzC+8aIRPS4kP9Zk1/ASiPoWfFH8jC0o8Tz+nc+1XMoBmI5ApkqrhrC9rvjgoT3GGCUkJUa8CxC0kJJrPsQDhLodH8bCmyWuioQXkLYwI1kUXhmLjjpfordFwG/w0cPJ5A2nQ64laBET3Ulx/72iOpWx1YBKQ+v/QGhanjeZ15LGkdvopOXrdnItN8ewf3i6jBXyMOXdQPogc+ZD4VBMl3+k/++5uFtYAxP9wZ191cRJs8rYiUtd7Lyp8Kte2vZeZAebuipn/gi8qlLbCp/4cxB5XOu64kvcvbyKi145dLvzrs45+AfCPZYQS9efdN+B0AnYJVDcgkv9Hom2Ex6YoZBySjoTtlKgcYoo1KleRhpZ2CbkUgTAsHJ8U+uapchfWOv4zuF23ujg4GkKj7GQveRhz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199015)(66946007)(66556008)(66476007)(6916009)(316002)(8676002)(4326008)(6666004)(86362001)(26005)(41300700001)(6506007)(478600001)(6486002)(2906002)(83380400001)(6512007)(186003)(33716001)(44832011)(8936002)(9686003)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QMFLCoYsa+14T2orLcA8UHnkuXhSq+JES48F/HABo3nOVZikbUoMBFxiEiUU?=
 =?us-ascii?Q?6sSsT5dOABx/+2XlLEQZZfaSs5dOWeZ+aWjQeZI5y5GaTvj7Cl3FWx0CNe9+?=
 =?us-ascii?Q?YH5i22pJKCSyUmsPMBPLcoz5S6c7Qfvg2qN6v5lBiVq5suwhFsWdhUIkaO3E?=
 =?us-ascii?Q?HpsYXgp/UkObY7RmkiMjWDszm3GD1IEtzelt8KlGMx1QaXNVT9fy40rCIvE9?=
 =?us-ascii?Q?2U68foYOR0dpLmb2mw23dVzT6EoRUes4AOcFIWi2YN+8khpRsri6pwWD4hvt?=
 =?us-ascii?Q?9kij86eMxEd0zmaDVtux/JMqSeVVcxHT/7mYV6+7SAcoDTf9KYre8nTk9lZ1?=
 =?us-ascii?Q?x8XpqVwqjdpqUKAoiLcQzAyv0/NImCr1XK+a4y2kLGrC/YrsV2kfnv336KS7?=
 =?us-ascii?Q?KV203jaCO88VW8Iq+2nnThyN2csNxHncYV3G8jx/OjGVFtfgv/apZSAvZ1UD?=
 =?us-ascii?Q?EFlidZlS1uo4fabIF7VwLE2qEXbhn45rFmSmMYGzY2CeJBjzXE8XXmko4JmO?=
 =?us-ascii?Q?hcFGrrzR8fimAu99beyheFr41cf2s8GWcYKIlQgI9Gi9IvQG4pnOPLjr1qCX?=
 =?us-ascii?Q?F2oITNvBloLXjOQZzLHEFbIRBwDU7X0SOWlUuxHTq7Z2sJFdDMjB2djemlKI?=
 =?us-ascii?Q?mQYTDvTXm0GqmoTZ9i4L0COKC/BSZKElO+m18KuKWUxD5E7eelqiCeBO0OH4?=
 =?us-ascii?Q?P9VnOm1utZ7zMVodBo6fbd5kSAbhKGx10+XFRUmVXAfAhWoqnwwIn73IXB0z?=
 =?us-ascii?Q?7hSHwOcuTLEVl+rZSAP0qer8z5edNUOAjWs2/xr06//ownVRtZFy1ChlMOyT?=
 =?us-ascii?Q?VUn5o1IFKUI9sKshCgIiaUaUk5WAgHLFa+F3ptd33gml6eQuVBeDTuuC27dZ?=
 =?us-ascii?Q?GNqM25xsi7P2X4V+2n0Tnx8Tw8slMscDKnSDZHPMBqHCXKiNmU7oGBo1HO87?=
 =?us-ascii?Q?FVSWL46/FC5OIgLXKlKO2w27kagXRxDJTglvdIFdypPs/QZyiTUg85PvYijA?=
 =?us-ascii?Q?w6QxZXjodQhrAgGMTxSG8zPvb6OpMEmTYT8TlDrU/pmFlR/IJcgSoORSmJEc?=
 =?us-ascii?Q?iKzamoyUJmV0AXFe8xEuqM2dQpKR2RuPa4Z/WD1f5aeIppCzopJF2asmlRq+?=
 =?us-ascii?Q?5R/hFj2HXuFfNrShqIZ5x0bRd4hTn5LwTXYrdTDE2qQyvfPmJCsclo74MvMZ?=
 =?us-ascii?Q?Pd6ks6qohCHK1C2t4CSXny5+nYzeZOLPaDdR6kEldTqI5oRYfcwjH5MxFAMt?=
 =?us-ascii?Q?Gm5mQmkOZukEch256chafEwto93jXKoUvq+tt0j+5p4GtJaztZ0NvRAAkAMG?=
 =?us-ascii?Q?ZPhkYmKaFqOZ6rZjpjz7w8uRnsyiwVNdn1htqz8ZoHTUip0ysRWpPIPwvHHj?=
 =?us-ascii?Q?bnUhwnuj0UiSbD8Wbf0RrPJCUHdrA7uFotjKJCgjzy5TPP1dVrbXSFRsJDwa?=
 =?us-ascii?Q?Iozg8qecp4+5hhVMfQ+KA7lbp3qTOjZAR+A5rztlrIZnejDLubDAbnbx77z6?=
 =?us-ascii?Q?N4zsE37JHRvdqadaJeBUgWim1YMOvaqx59ALBQl0blNYmRlTQhSPz4pLPAe8?=
 =?us-ascii?Q?GsvKTvrjBnPJZgESYSzWhhRjYJO4mv31wpg1DNST6KjYRpRtQWiqrb3bZTzd?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8fbd48-ce96-49c6-e427-08daad106132
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 11:45:09.0184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytUG/V6cP5braS/d/0p727TFAQRx0WQwZvAewVANmNnkdbDpbDuJ04B5Vs0+9GWjIbsS6jljMOamVAP8B6BRH8UM8lW2nXSXwnkwJESK/HE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6168
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_08,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130069
X-Proofpoint-ORIG-GUID: chjzuxeOBDwIwMVo1ZFE7UW9sy3o2Hyi
X-Proofpoint-GUID: chjzuxeOBDwIwMVo1ZFE7UW9sy3o2Hyi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Krishna Yarlagadda,

The patch 8777dd9dff40: "spi: tegra210-quad: Fix combined sequence"
from Oct 1, 2022, leads to the following Smatch static checker
warning:

	drivers/spi/spi-tegra210-quad.c:1160 tegra_qspi_combined_seq_xfer()
	warn: iterator used outside loop: 'xfer'

drivers/spi/spi-tegra210-quad.c
    1046 static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
    1047                                         struct spi_message *msg)
    1048 {
    1049         bool is_first_msg = true;
    1050         struct spi_transfer *xfer;
    1051         struct spi_device *spi = msg->spi;
    1052         u8 transfer_phase = 0;
    1053         u32 cmd1 = 0, dma_ctl = 0;
    1054         int ret = 0;
    1055         u32 address_value = 0;
    1056         u32 cmd_config = 0, addr_config = 0;
    1057         u8 cmd_value = 0, val = 0;
    1058 
    1059         /* Enable Combined sequence mode */
    1060         val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
    1061         val |= QSPI_CMB_SEQ_EN;
    1062         tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
    1063         /* Process individual transfer list */
    1064         list_for_each_entry(xfer, &msg->transfers, transfer_list) {
                                     ^^^^
"xfer" is the list iterator.  If we exit the loop because the list is
complete (as opposed to exiting the loop because we hit a break), then
the "xfer" pointer does not pointe to valid memory.

    1065                 switch (transfer_phase) {
    1066                 case CMD_TRANSFER:
    1067                         /* X1 SDR mode */
    1068                         cmd_config = tegra_qspi_cmd_config(false, 0,
    1069                                                            xfer->len);
    1070                         cmd_value = *((const u8 *)(xfer->tx_buf));
    1071                         break;
    1072                 case ADDR_TRANSFER:
    1073                         /* X1 SDR mode */
    1074                         addr_config = tegra_qspi_addr_config(false, 0,
    1075                                                              xfer->len);
    1076                         address_value = *((const u32 *)(xfer->tx_buf));
    1077                         break;
    1078                 case DATA_TRANSFER:
    1079                         /* Program Command, Address value in register */
    1080                         tegra_qspi_writel(tqspi, cmd_value, QSPI_CMB_SEQ_CMD);
    1081                         tegra_qspi_writel(tqspi, address_value,
    1082                                           QSPI_CMB_SEQ_ADDR);
    1083                         /* Program Command and Address config in register */
    1084                         tegra_qspi_writel(tqspi, cmd_config,
    1085                                           QSPI_CMB_SEQ_CMD_CFG);
    1086                         tegra_qspi_writel(tqspi, addr_config,
    1087                                           QSPI_CMB_SEQ_ADDR_CFG);
    1088 
    1089                         reinit_completion(&tqspi->xfer_completion);
    1090                         cmd1 = tegra_qspi_setup_transfer_one(spi, xfer,
    1091                                                              is_first_msg);
    1092                         ret = tegra_qspi_start_transfer_one(spi, xfer,
    1093                                                             cmd1);
    1094 
    1095                         if (ret < 0) {
    1096                                 dev_err(tqspi->dev, "Failed to start transfer-one: %d\n",
    1097                                         ret);
    1098                                 return ret;
    1099                         }
    1100 
    1101                         is_first_msg = false;
    1102                         ret = wait_for_completion_timeout
    1103                                         (&tqspi->xfer_completion,
    1104                                         QSPI_DMA_TIMEOUT);
    1105 
    1106                         if (WARN_ON(ret == 0)) {
    1107                                 dev_err(tqspi->dev, "QSPI Transfer failed with timeout: %d\n",
    1108                                         ret);
    1109                                 if (tqspi->is_curr_dma_xfer &&
    1110                                     (tqspi->cur_direction & DATA_DIR_TX))
    1111                                         dmaengine_terminate_all
    1112                                                 (tqspi->tx_dma_chan);
    1113 
    1114                                 if (tqspi->is_curr_dma_xfer &&
    1115                                     (tqspi->cur_direction & DATA_DIR_RX))
    1116                                         dmaengine_terminate_all
    1117                                                 (tqspi->rx_dma_chan);
    1118 
    1119                                 /* Abort transfer by resetting pio/dma bit */
    1120                                 if (!tqspi->is_curr_dma_xfer) {
    1121                                         cmd1 = tegra_qspi_readl
    1122                                                         (tqspi,
    1123                                                          QSPI_COMMAND1);
    1124                                         cmd1 &= ~QSPI_PIO;
    1125                                         tegra_qspi_writel
    1126                                                         (tqspi, cmd1,
    1127                                                          QSPI_COMMAND1);
    1128                                 } else {
    1129                                         dma_ctl = tegra_qspi_readl
    1130                                                         (tqspi,
    1131                                                          QSPI_DMA_CTL);
    1132                                         dma_ctl &= ~QSPI_DMA_EN;
    1133                                         tegra_qspi_writel(tqspi, dma_ctl,
    1134                                                           QSPI_DMA_CTL);
    1135                                 }
    1136 
    1137                                 /* Reset controller if timeout happens */
    1138                                 if (device_reset(tqspi->dev) < 0)
    1139                                         dev_warn_once(tqspi->dev,
    1140                                                       "device reset failed\n");
    1141                                 ret = -EIO;
    1142                                 goto exit;
    1143                         }
    1144 
    1145                         if (tqspi->tx_status ||  tqspi->rx_status) {
    1146                                 dev_err(tqspi->dev, "QSPI Transfer failed\n");
    1147                                 tqspi->tx_status = 0;
    1148                                 tqspi->rx_status = 0;
    1149                                 ret = -EIO;
    1150                                 goto exit;
    1151                         }
    1152                         break;
    1153                 default:
    1154                         ret = -EINVAL;
    1155                         goto exit;
    1156                 }
    1157                 msg->actual_length += xfer->len;
    1158                 transfer_phase++;
    1159         }
--> 1160         if (!xfer->cs_change) {
                     ^^^^^^^
list iterator used outside of loop.

    1161                 tegra_qspi_transfer_end(spi);
    1162                 spi_transfer_delay_exec(xfer);
    1163         }
    1164         ret = 0;
    1165 
    1166 exit:
    1167         msg->status = ret;
    1168 
    1169         return ret;
    1170 }

regards,
dan carpenter
