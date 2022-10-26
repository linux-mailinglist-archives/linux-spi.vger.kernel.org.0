Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3118B60E081
	for <lists+linux-spi@lfdr.de>; Wed, 26 Oct 2022 14:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiJZMUe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Oct 2022 08:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbiJZMUc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Oct 2022 08:20:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA8836DE1
        for <linux-spi@vger.kernel.org>; Wed, 26 Oct 2022 05:20:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QBENFH031933;
        Wed, 26 Oct 2022 12:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=2NdXAc+ZLOT3OLuURg2QaApjnuTLshcasbuEIlBMsuE=;
 b=qyOrUrls7DOKl9ma+n1rYuzR/tDRInn3yrhc65L5cuK98ilkcrtn+Ov9C4BP3BMLawml
 wDeQxrv8MoYPMvg4Ix+W3vfDg5C2GkF3BddOWEGKfPhJef3G6EGoE51FukMQbb18JatJ
 tzpznlejQA/1Fncrcel186vaPakqbljnhsVVuCNqcl6KuEW4Tfl8m/xgBEXvcNmUx15x
 ZZQZMlwRIy8vnN/rXjXhE9o0PlkEI+VZ2fZrZxL+myAhOyzqqe7UW6blzzkL7kSndu7V
 53/8QC7NF5HEXUvdfUAbBQCs6f9KmuyDBWvfsm3zt5GBDZM1/pnUZ4PhZwJQZz1A2fRi ZA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc7a36f8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 12:20:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29QAWSP5011118;
        Wed, 26 Oct 2022 12:20:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y5pss7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 12:20:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExzkdK4ThnguvhPmLEAkyrFIr+xWHqrzrCDBGKMVM8/fBWBqYfURgcL0jw4n4N3aYPEDed/ezeRGjIJGtWcvWiDsH4OeoOJVUDyNJwExIccIf9kaz8ymygLqpCCGUVRRGPPNknaroZKl8c6yLP+7vXhgS0SDl51D6/DK7h26ttO+AOaS7vg41fL3CRrTNV5k7jn2x7C+jUHxiUnnlMS4hSquM2DvsWw6pjHcIy8NzjuI+/nXG2sS3uty7j6SJ8cgJDXEfLMYOfU+nX2RXLMF35WS+nXRKzjS8lA+l3MSgefw01NdQkFfp8YfwAF0sGATCwTx85lDCzcADVx5/I0x+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NdXAc+ZLOT3OLuURg2QaApjnuTLshcasbuEIlBMsuE=;
 b=POubY9bohrjlzyIHEL/Y+OnSmThiMstjYGfisnQ+HOpimXqO/4trmco2cmXxfyQd86ErNKG1KCntG5OGlDcVPpHx8nzvlG9tEUBoJIksHMoT7v36rXCW2CpumdKAQCkLuxOuEgbqbfjQkWQ6k4hxmAHhPHUsEhbz+s276C4U+DPj2d3oco1+tXB3jGqb7htlgPuZIA0Lt3Lxeerq+KtDvRrQ1osDx3zuFAx1GdCPLfXk3wDFooCBBKjOQb2UiBh5//gJ9Tb1qE/ikxXYcOaKAqD/iBYieGzsZT9BvvsMOewvms4rhaGnTJHG57o+q9htIhfplY0B92rLdMLoJZTGzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NdXAc+ZLOT3OLuURg2QaApjnuTLshcasbuEIlBMsuE=;
 b=uqP/2itb+ZWE4j6fu/cmSdtqmsCf2MyzXQfMTX/F4fSgvhwoTnH7TBK25/yLPdmPtTbnGSLDfOascvQ5b1Pe1qxILBwxCKy+/gWlZS3GOo8iSvb3kbq/BS+iDvqhO+8uEu2/CctM8gPjsAGnlFQ5kaP61r/1UvmHE8/l0hfnsyI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB5023.namprd10.prod.outlook.com
 (2603:10b6:5:38d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 12:20:25 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Wed, 26 Oct 2022
 12:20:25 +0000
Date:   Wed, 26 Oct 2022 15:20:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     huangfq.daxian@gmail.com
Cc:     linux-spi@vger.kernel.org
Subject: [bug report] mfd: ezx-pcap: Replace mutex_lock with spin_lock
Message-ID: <Y1kmAN62MalAODUL@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0123.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|DS7PR10MB5023:EE_
X-MS-Office365-Filtering-Correlation-Id: 90fc1c79-e2ca-4125-a1e8-08dab74c7617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELHSRXu8zy4Kw4CcOLcMOlcqI7WnkQXMXO2kwdASCFtJWKxs07L6xfppUQqG0KGJyvxesZml70sDvmSVBjWAV4xv5ko8kaJExZTUUuAbp9/MlhvcK1LvR3JGR+rPPWRPJovNHP1Y8/tqnakLqTKCR/fSaNU1WT1UgAYGiilzoEg9y4rUX1tlqOH2MJL6v0J0m7ta16odFnK9AkdnyxEqxS/II9CerCdiEA0+zaquC/YmZysUKHvjzDUjBwpUYvzK0VcF9GvMxHVXSPe5QgGNrMWXv6J77S4IUk4CxG52kfTYD/pD8ZxtYTJhfsM4Cj6kpRSr4E5G36KstkFhcezzKVZ+ZxLsWJMGI540oaUjfgaJy2mRG1Qurp3QdRP5bA/bwnsldJm8FZ+aYNhhbGYkyv+T6Gx1iJPickED0yEgs7a+2QXS77qvtIiRxjNaFECKhvv6RoJpifApJIkKD4IV2gS5wCMadh5nZxMmnZoeH7zn6ywFsB17h69du7/LYbXZ9NPJHjfCxWOJjga0ysCG23ICRsm/An7G+J+RoOfmBPWKbya8L6/2B7evnud+DNfamK9WdHgHhHH53CRBy2Aui/2E7XpmoQuk623MngW5KxWjmlxRl0gIavBM5kggfvfQcuqUsRLvbRVFyj6QruuBErpWj8MEKyYHjyEk8uE2nSk1LaQkCPUCMztB83DJSVnecp5DPTSW969ehDABCWoPkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199015)(478600001)(2906002)(44832011)(186003)(33716001)(38100700002)(6486002)(6666004)(66476007)(4326008)(8676002)(66946007)(41300700001)(66556008)(6506007)(6916009)(6512007)(8936002)(26005)(5660300002)(316002)(9686003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EGkt+HPlSH1wuuYLdHAqflegP8H04S1YhLsFKaT9rFvd7YFI40p666C9I08B?=
 =?us-ascii?Q?u9+chEWhE4Ttmwtxi/Rf8N3zE6yI0HoexBvYRgQHvACulVrENu/yz9XjZ4r3?=
 =?us-ascii?Q?sCAP2/BXokOOZYWMZuKRK/b54sks5LopCBvLviBSXKLLKxyx9s6N0G3JmfGo?=
 =?us-ascii?Q?eyFY65IgAjBn0MDTlwy8Eqm+uF0sovjxExOxWVTWZFt2JKfJkamsnOWnowaw?=
 =?us-ascii?Q?u3K5DZXEH4Q6d1ZbCA9aLRQlHvaSuYuLVj5b+9CFQn/v476RkdI1e36fmfo+?=
 =?us-ascii?Q?gXptXAZKfoNaCPGpKTRFyw09Skit47JWqCBPgVGrOklaXMxujq24Y9EuHHNt?=
 =?us-ascii?Q?Keuho6R4W6//fqiynqPSK4LvUZRoM/4Gvrn/nCL+LrsXil30o2cR5mx8vjlF?=
 =?us-ascii?Q?+4LvM1QJtZwzIqTJ+ienSzS2OJ1GsfcjhQTmqw+bgHcFB+drDIsMMjYw6Ulr?=
 =?us-ascii?Q?0FZ3H2ERQyc7mErO7UtvGY6ekwJfWjH0H94l9gt+rlbknD73k7syEeQEUtew?=
 =?us-ascii?Q?Ue8UfPpTPvjxY24uPRiomHzYFCN6IpGdYkRgd/mst2vRytQaL6oSjRqNQchU?=
 =?us-ascii?Q?umZBvgGX854K6n26fnQ/OJtDddSxsBuTFDl1zCIe7IHYiUA5j8z/xQMZLevl?=
 =?us-ascii?Q?j9+1udDtuCPz4f84cZnI1VGCHeDLpaXOMIu7YOLqmqdVSIeqGkTV3Pxxk/hK?=
 =?us-ascii?Q?PGecQ9PEbkW062w+lrkY0GyE6yUIDAmPHc/M1Ak+T85GlqnSlm8psFHSaEhb?=
 =?us-ascii?Q?3BR4gvmu6klJ/8P40xVoI7K1PV8GU7Sw/F1D/pelAHwvtaihaE+vJMxT9fEk?=
 =?us-ascii?Q?LTvaSU2PVRLabQ57cPtu7s79WMTmLfysKwPQkYvkGkQMwoBp9B5ZqsvKVuUl?=
 =?us-ascii?Q?x1pi7QacqVCqJtiSnFO4aMpYCUxnioeNZcFLj1oLaDdBWSLJtKtdB19T2Rw7?=
 =?us-ascii?Q?ipI2cLTXl4HjVHedbFbJtOzZuS/SETkN10G2iZcHh6VsXxQ4EQuK0nnBYWCU?=
 =?us-ascii?Q?LSWL+2uoy8yecHeXiSCxnqMnM+smDLjAGYJ3qq6wj6VlCbVKTPSENqDKfLCI?=
 =?us-ascii?Q?llUYL1zu1WLpKmKIe7bv2g2zee3zNAYKNIHOqqAiC37NIN7dJ87W/oeqGDNY?=
 =?us-ascii?Q?h5csOGYy3c0UGFYg+IgrY/MTYSSOprPzkGoSsuzYmUbaO37yH+1n90Q4dJHZ?=
 =?us-ascii?Q?iPuQKS26YV6cpofxgtsf6geofqL2E5DHlUUqy8B0pPfmvid+Oip9QmBrPrfv?=
 =?us-ascii?Q?/V5pYgg7nGl79D6ZfriZmuCZ4XPKpqW8dyp6W9D7TtC/R7gDvzhTpxm65kvR?=
 =?us-ascii?Q?/pIFUCj2yrkK83CCA4v7TirSrhxh9n2XYTlcZrJRiMU5XrHerMCgBh57A6gI?=
 =?us-ascii?Q?BZT57nt5wtGpyR2XrU5r/T3X5aUa5dEc2bJQx+DOKEa+W4F/PnCk4TrIgbhz?=
 =?us-ascii?Q?FYORGjXJfLFOInNwv5AerJiQ1E+QGKxWGrEMMKA4t8tq0dI+sivv/Q06Gkvc?=
 =?us-ascii?Q?1glRFWuwZ8yiPNQAF4hKoBrqi9YBp++d/6aXWEEFRp13nl9hpnJ5lNQSDSj8?=
 =?us-ascii?Q?wjCxt6/XG3y+/Sl20XR4pBJEDivr3Vl9lXDxBg2GvCmeMtGuBzEu7SdjGw8B?=
 =?us-ascii?Q?8g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90fc1c79-e2ca-4125-a1e8-08dab74c7617
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 12:20:25.8160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ll2YeoPsnSlq/HuYo15OtfQfpe8p+PJFu7MNb6Zwy6T+3vtzyZ0LUe14npv4ToEa2LHBbCSkUtesbLagAb5DMDWOjN0XSJqk8VOFX6SIFQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5023
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_06,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=870 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210260069
X-Proofpoint-GUID: ZaCgGwS1ZajaPs8Dal6XqNgcsfn8BJ-v
X-Proofpoint-ORIG-GUID: ZaCgGwS1ZajaPs8Dal6XqNgcsfn8BJ-v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Fuqian Huang,

The patch b65dc4f6b339: "mfd: ezx-pcap: Replace mutex_lock with
spin_lock" from Aug 13, 2019, leads to the following Smatch static
checker warning:

	drivers/spi/spi.c:1666 __spi_pump_transfer_message()
	warn: sleeping in atomic context

One problematic call tree is:

ezx_pcap_set_bits() <- disables preempt
  -> ezx_pcap_putget()
     -> spi_sync()

drivers/mfd/ezx-pcap.c
   109  int ezx_pcap_set_bits(struct pcap_chip *pcap, u8 reg_num, u32 mask, u32 val)
   110  {
   111          unsigned long flags;
   112          int ret;
   113          u32 tmp = PCAP_REGISTER_READ_OP_BIT |
   114                  (reg_num << PCAP_REGISTER_ADDRESS_SHIFT);
   115  
   116          spin_lock_irqsave(&pcap->io_lock, flags);

This use to be a mutex but it was change to a spinlock to avoid a
sleeping in atomic bug.

   117          ret = ezx_pcap_putget(pcap, &tmp);

But ezx_pcap_putget() calls spi_sync() which takes a mutex so the fix
is not complete.

   118          if (ret)
   119                  goto out_unlock;
   120  
   121          tmp &= (PCAP_REGISTER_VALUE_MASK & ~mask);
   122          tmp |= (val & mask) | PCAP_REGISTER_WRITE_OP_BIT |
   123                  (reg_num << PCAP_REGISTER_ADDRESS_SHIFT);
   124  
   125          ret = ezx_pcap_putget(pcap, &tmp);
   126  out_unlock:
   127          spin_unlock_irqrestore(&pcap->io_lock, flags);
   128  
   129          return ret;
   130  }

regards,
dan carpenter
